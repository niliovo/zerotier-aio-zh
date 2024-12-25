# Zerotier-Aio-Zh

- [中文](./README.md)
- [ENGLISH](./README_EN.md)

- [Github](https://github.com/niliovo/zerotier-aio-zh)
- [Docker Hub](https://hub.docker.com/r/niliaerith/zerotier-aio-zh)

## 项目说明

> 本项目基于下列项目,汉化 ztncui-aio 并打包镜像

- [zerotier/ZeroTierOne](https://github.com/zerotier/ZeroTierOne)
- [kmahyyg/ztncui-aio](https://github.com/kmahyyg/ztncui-aio)
- [key-networks/ztncui](https://github.com/key-networks/ztncui)

**注意，本仓库为汉化仓库，提交ISSUE请前往[原仓库](https://github.com/kmahyyg/ztncui-aio)**

### 支持平台

- x86_64
- arm64

- arm32(需自行编译)
- ~~x86_32(Node.js不兼容)~~

> 提示：多平台镜像为QEMU模拟不同平台编译，可能存在问题，如果镜像不可用，请尝试自行编译

## 使用说明

### Docker Compose

#### host模式

```compose.yml
  zerotier-aio-zh:
    image: niliaerith/zerotier-aio-zh:latest
    container_name: zerotier-aio-zh
    hostname: zerotier-aio-zh
    restart: always
    cap_add:
      - ALL
    devices:
      - /dev/net/tun
    network_mode: host
    volumes:
      - /your_path/zerotier-aio-zh/opt/key-networks/ztncui/etc:/opt/key-networks/ztncui/etc
      - /your_path/zerotier-aio-zh/var/lib/zerotier-one:/var/lib/zerotier-one
      - /your_path/zerotier-aio-zh/etc/zt-mkworld:/etc/zt-mkworld
    environment:
      - TZ=Asia/Shanghai
      - AUTOGEN_PLANET=0
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

#### bridge模式

```compose.yml
  zerotier-aio-zh:
    image: niliaerith/zerotier-aio-zh:latest
    container_name: zerotier-aio-zh
    hostname: zerotier-aio-zh
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
      - /your_path/zerotier-aio-zh/opt/key-networks/ztncui/etc:/opt/key-networks/ztncui/etc
      - /your_path/zerotier-aio-zh/var/lib/zerotier-one:/var/lib/zerotier-one
      - /your_path/zerotier-aio-zh/etc/zt-mkworld:/etc/zt-mkworld
    environment:
      - TZ=Asia/Shanghai
      - AUTOGEN_PLANET=0
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

### Docker Cli

#### host模式

```sh
docker run -itd --name zerotier-aio-zh --hostname zerotier-aio-zh --net host --restart always --cap-add=NET_ADMIN --device /dev/net/tun:/dev/net/tun -v /your_path/zerotier-aio-zh/opt/key-networks/ztncui/etc:/opt/key-networks/ztncui/etc -v /your_path/zerotier-aio-zh/var/lib/zerotier-one:/var/lib/zerotier-one -v /your_path/zerotier-aio-zh/etc/zt-mkworld:/etc/zt-mkworld -e TZ=Asia/Shanghai -e AUTOGEN_PLANET=0 -e NODE_ENV=production -e HTTPS_HOST=xxx.xxx.xxx.xxx -e HTTPS_PORT=3443 -e HTTP_PORT=3000 -e HTTP_ALL_INTERFACES=yes -e MYDOMAIN=ztncui.docker.test -e ZTNCUI_PASSWD=YourPassWD -e MYADDR=PublicIP --privileged=true niliaerith/zerotier-aio-zh:latest

```

#### bridge模式

```sh
docker run -itd --name zerotier-aio-zh --hostname zerotier-aio-zh --net bridge -p3000:3000 -p3180:3180 -p3443:3443 -p9993:9993/udp --restart always --cap-add=NET_ADMIN --device /dev/net/tun:/dev/net/tun -v /your_path/zerotier-aio-zh/opt/key-networks/ztncui/etc:/opt/key-networks/ztncui/etc -v /your_path/zerotier-aio-zh/var/lib/zerotier-one:/var/lib/zerotier-one -v /your_path/zerotier-aio-zh/etc/zt-mkworld:/etc/zt-mkworld -e TZ=Asia/Shanghai -e AUTOGEN_PLANET=0 -e NODE_ENV=production -e HTTPS_HOST=xxx.xxx.xxx.xxx -e HTTPS_PORT=3443 -e HTTP_PORT=3000 -e HTTP_ALL_INTERFACES=yes -e MYDOMAIN=ztncui.docker.test -e ZTNCUI_PASSWD=YourPassWD -e MYADDR=PublicIP --privileged=true niliaerith/zerotier-aio-zh:latest
```

### 自行编译

```
git clone https://github.com/niliovo/zerotier-aio-zh.git
cd zerotier-aio-zh
docker build -t zerotier-aio-zh .
# 将上述镜像 'niliaerith/zerotier-aio-zh' 替换为 'zerotier-aio-zh'
```

## 变量

- `AUTOGEN_PLANET=0`如果设置为 1，将使用此节点身份生成planet文件并放入httpfs文件夹以在外部提供服务。如果设置为 2，将使用`/etc/zt-mkworld/mkworld.config.json`. 如果设置为 0，则不执行任何操作(默认为0)。
- `mkworld,config.json`参考如下

```json
{
    "rootNodes": [   // 节点数组，可以是多个
        {
            "comments": "amsterdam official",   // 节点对象,在 AUTOGEN_PLANET=1 时将自动生成
            "identity": "992fcf1db7:0:206ed59350b31916f749a1f85dffb3a8787dcbf83b8c6e9448d4e3ea0e3369301be716c3609344a9d1533850fb4460c50af43322bcfc8e13d3301a1f1003ceb6",  
            // 节点 identity.public ^^ , 如果节点未初始化，则会在容器启动时初始化
            "endpoints": [
                "195.181.173.159/443",   // 节点服务位置，格式为：IP/端口，如果 AUTOGEN_PLANET=1 将自动生成
                "2a02:6ea0:c024::/443"   // 必须小于或等于两个端点，一个用于 IPv4，一个用于 IPv6。如果有多个 IP，则设置具有不同标识的多个节点。
        }
    ],
    "signing": [
        "previous.c25519",   // 行星签名密钥，如果不存在，将生成
        "current.c25519"   // 相同，用于迭代和更新
    ],
    "output": "planet.custom",   // 输出文件名
    "plID": 0,    // 行星数字 ID，如果不知道，请勿修改，并将 plRecommend 设置为 true
    "plBirth": 0,  // 行星创建时间戳，如果不知道，请勿修改，并将 plRecommend 设为 true
    "plRecommend": true  // 将 plRecommend 设为 true，自动推荐 plID、plBirth 值。更多详情，请阅读 zerotier-one 官方软件仓库中的 mkworld 源代码
}
```

- `NODE_ENV=production` (此变量为必须需要)节点环境，默认为`production`
- `HTTPS_HOST=xxx.xxx.xxx.xxx` HTTPS_主机,仅监听 HTTPS_HOST:HTTPS_PORT
- `HTTPS_PORT=3443` HTTPS_端口，默认`3443`
- `HTTP_PORT=3000` HTTP_端口，默认为`3000`
- `HTTP_ALL_INTERFACES` 监听所有接口，对于反向代理有用，仅 HTTP
- `MYDOMAIN=ztncui.docker.test` 域名，动态生成 TLS 证书（如果不存在）
- `ZTNCUI_PASSWD=YourPassWD` WebUI密码,默认用户名为admin
- `MYADDR` 公网IP地址，如果未设置将自动检测

> 更多用法详见[kmahyyg/ztncui-aio](https://github.com/kmahyyg/ztncui-aio)

# 感谢

- [zerotier/ZeroTierOne](https://github.com/zerotier/ZeroTierOne)
- [kmahyyg/ztncui-aio](https://github.com/kmahyyg/ztncui-aio)
- [key-networks/ztncui](https://github.com/key-networks/ztncui)
- [GitHub](https://github.com/)
- [Docker Hub](https://hub.docker.com/)

## STAR 历史

<a href="https://star-history.com/#niliovo/zerotier-aio-zh&Date">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=niliovo/zerotier-aio-zh&type=Date&theme=dark" />
    <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=niliovo/zerotier-aio-zh&type=Date" />
    <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=niliovo/zerotier-aio-zh&type=Date" />
  </picture>
</a>
