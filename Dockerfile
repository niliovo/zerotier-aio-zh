FROM node:slim AS jsbuilder
ENV NODEJS_MAJOR=18
ENV DEBIAN_FRONTEND=noninteractive

# BUILD ZTNCUI IN FIRST STAGE
WORKDIR /build
COPY ztncui.sh .
RUN chmod a+x ztncui.sh && ./ztncui.sh

# BUILD GO UTILS
FROM golang:bookworm AS gobuilder
WORKDIR /buildsrc
COPY --from=jsbuilder /build/argon2g /buildsrc/argon2g
COPY --from=jsbuilder /build/fileserv /buildsrc/fileserv
COPY --from=jsbuilder /build/ztnodeid /buildsrc/ztnodeid
COPY --from=jsbuilder /build/build-gobinaries.sh /buildsrc/build-gobinaries.sh
ENV CGO_ENABLED=0
RUN apt update -y && \ 
    apt install zip -y && \
    bash /buildsrc/build-gobinaries.sh

# START RUNNER
FROM debian:bookworm-slim AS runner
ENV DEBIAN_FRONTEND=noninteractive
ENV AUTOGEN_PLANET=0
WORKDIR /tmp
COPY runner.sh .
RUN chmod a+x runner.sh && bash runner.sh

WORKDIR /opt/key-networks/ztncui
COPY --from=jsbuilder /build/artifact.zip .
RUN unzip ./artifact.zip && \
    rm -f ./artifact.zip

WORKDIR /
COPY --from=jsbuilder /build/start_firsttime_init.sh /start_firsttime_init.sh
COPY --from=jsbuilder /build/start_zt1.sh /start_zt1.sh
COPY --from=jsbuilder /build/start_ztncui.sh /start_ztncui.sh

COPY --from=gobuilder /buildsrc/artifact-go.zip /tmp/
RUN unzip -d /usr/local/bin /tmp/artifact-go.zip && \
    rm -rf /tmp/artifact-go.zip && \
    chmod 0755 /usr/local/bin/* && \
    chmod 0755 /start_*.sh

COPY --from=jsbuilder /build/s6-rc.d/ /etc/s6-overlay/s6-rc.d/

EXPOSE 3000/tcp
EXPOSE 3180/tcp
EXPOSE 8000/tcp
EXPOSE 3443/tcp

VOLUME ["/opt/key-networks/ztncui/etc", "/etc/zt-mkworld", "/var/lib/zerotier-one"]
ENTRYPOINT [ "/init" ]