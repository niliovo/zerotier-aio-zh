# zerotier-aio-zh

**注意，本仓库为汉化仓库，提交ISSUE请前往[原仓库](https://github.com/kmahyyg/ztncui-aio)**

- [中文](./README.md)
- [ENGLISH](./README_EN.md)

- [Github](https://github.com/niliovo/zerotier-aio-zh)
- [Docker Hub](https://hub.docker.com/r/niliaerith/zerotier-aio-zh)

# 本项目基于下列项目,汉化 ztncui-aio 并打包镜像

- [zerotier/ZeroTierOne](https://github.niliovo.top/zerotier/ZeroTierOne)
- [kmahyyg/ztncui-aio](https://github.com/kmahyyg/ztncui-aio)
- [key-networks/ztncui](https://github.com/key-networks/ztncui)

# 使用指南

## Docker-Cli使用指南

- amd64/arm64/armv7
- host模式

```sh
docker run -itd --name ztncui-aio-zh --hostname ztncui-aio-zh --net host --restart always --cap-add=NET_ADMIN --device /dev/net/tun:/dev/net/tun -v /your_path/ztncui-aio-zh/opt/key-networks/ztncui/etc:/opt/key-networks/ztncui/etc -v /your_path/ztncui-aio-zh/var/lib/zerotier-one:/var/lib/zerotier-one -v /your_path/ztncui-aio-zh/etc/zt-mkworld:/etc/zt-mkworld -e PUID=0 -e PGID=0 -e TZ=Asia/Shanghai -e NODE_ENV=production -e HTTPS_HOST=xxx.xxx.xxx.xxx -e HTTPS_PORT=3443 -e HTTP_PORT=3000 -e HTTP_ALL_INTERFACES=yes -e MYDOMAIN=ztncui.docker.test -e ZTNCUI_PASSWD=YourPassWD -e MYADDR=PublicIP --privileged=true niliaerith/zerotier-aio-zh:latest

```

- bridge模式

```sh
docker run -itd --name ztncui-aio-zh --hostname ztncui-aio-zh --net bridge -p3000:3000 -p3180:3180 -p3443:3443 -p9993:9993/udp --restart always --cap-add=NET_ADMIN --device /dev/net/tun:/dev/net/tun -v /your_path/ztncui-aio-zh/opt/key-networks/ztncui/etc:/opt/key-networks/ztncui/etc -v /your_path/ztncui-aio-zh/var/lib/zerotier-one:/var/lib/zerotier-one -v /your_path/ztncui-aio-zh/etc/zt-mkworld:/etc/zt-mkworld -e PUID=0 -e PGID=0 -e TZ=Asia/Shanghai -e NODE_ENV=production -e HTTPS_HOST=xxx.xxx.xxx.xxx -e HTTPS_PORT=3443 -e HTTP_PORT=3000 -e HTTP_ALL_INTERFACES=yes -e MYDOMAIN=ztncui.docker.test -e ZTNCUI_PASSWD=YourPassWD -e MYADDR=PublicIP --privileged=true niliaerith/zerotier-aio-zh:latest
```

## Docker Compose使用指南

- amd64/arm64/armv7
- host模式

```compose.yml
  ztncui-aio-zh:
    image: niliaerith/ztncui-aio-zh:latest
    container_name: ztncui-aio-zh
    hostname: ztncui-aio-zh
    restart: always
    cap_add:
      - ALL
    devices:
      - /dev/net/tun
    network_mode: host
    volumes:
      - /your_path/ztncui-aio-zh/opt/key-networks/ztncui/etc:/opt/key-networks/ztncui/etc
      - /your_path/ztncui-aio-zh/var/lib/zerotier-one:/var/lib/zerotier-one
      - /your_path/ztncui-aio-zh/etc/zt-mkworld:/etc/zt-mkworld
    environment:
      - PUID=0
      - PGID=0
      - TZ=Asia/Shanghai
      - NODE_ENV=production
      - HTTPS_HOST=xxx.xxx.xxx.xxx
      - HTTPS_PORT=3443
      - HTTP_PORT=3000
      - HTTP_ALL_INTERFACES=yes
      - MYDOMAIN=ztncui.docker.test
      - ZTNCUI_PASSWD=YourPassWD
      - MYADDR=PublicIP
    privileged: true
```

- bridge模式

```compose.yml
  ztncui-aio-zh:
    image: niliaerith/ztncui-aio-zh:latest
    container_name: ztncui-aio-zh
    hostname: ztncui-aio-zh
    restart: always
    cap_add:
      - ALL
    devices:
      - /dev/net/tun
    network_mode: bridge
    ports:
      - 3000:3000
      - 3180:3180
      - 3443:3443
      - 9993:9993/udp
    volumes:
      - /your_path/ztncui-aio-zh/opt/key-networks/ztncui/etc:/opt/key-networks/ztncui/etc
      - /your_path/ztncui-aio-zh/var/lib/zerotier-one:/var/lib/zerotier-one
      - /your_path/ztncui-aio-zh/etc/zt-mkworld:/etc/zt-mkworld
    environment:
      - PUID=0
      - PGID=0
      - TZ=Asia/Shanghai
      - NODE_ENV=production
      - HTTPS_HOST=xxx.xxx.xxx.xxx
      - HTTPS_PORT=3443
      - HTTP_PORT=3000
      - HTTP_ALL_INTERFACES=yes
      - MYDOMAIN=ztncui.docker.test
      - ZTNCUI_PASSWD=YourPassWD
      - MYADDR=PublicIP
    privileged: true
```

## 变量

- 详见[kmahyyg/ztncui-aio](https://github.com/kmahyyg/ztncui-aio)

## 支持平台

- amd64
- arm64
- armv7(未测试)

- ~~i386(node没有此版本，故不支持)~~

# 感谢

- [zerotier/ZeroTierOne](https://github.niliovo.top/zerotier/ZeroTierOne)
- [kmahyyg/ztncui-aio](https://github.com/kmahyyg/ztncui-aio)
- [key-networks/ztncui](https://github.com/key-networks/ztncui)
- [GitHub](https://github.com/)
- [Docker Hub](https://hub.docker.com/)
