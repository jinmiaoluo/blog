# 基于 SSH 的国内服务器加速访问国外网站的方案

在国内服务器上, 我们如果要访问国外的软件源站, 下载在 GitHub 上的 release, 或者是下载一些项目的依赖等, 由于物理线路长和国内特殊的环境问题, 我们就需要通过代理加速访问.

## 关键点
- 代理加速
- 服务器上不允许安装任何加速软件

## 步骤
我的开发环境有一个监听在 9090 的 HTTP 代理服务(由 [v2ray](https://v2ray.com/) 提供), 发给这个端口的请求会自动通过代理服务器进行代理请求并回传响应.

OpenSSH 支持将本地的端口映射到服务器上, 因此, 我们只要将本地的 9090 端口映射到服务器的任意端口(假设映射到服务器的 19090). 端口映射实现的方式是: 在 `~/.ssh/config` (如果没有需要新建)内添加如下配置:

```ssh
Host *
RemoteForward 127.0.0.1:19090 127.0.0.1:9090
```

然后登陆你的服务器, 在服务器上, 执行下面两条命令:

```shell script
export http_proxy="http://127.0.0.1:19090"
export https_proxy="http://127.0.0.1:19090"
```

服务器的命令行即可使用你本地的 HTTP 代理

使用了代理和未使用代理速度对比:

[![asciicast](https://asciinema.org/a/1pKbh06SlM1vu9g0OF68EJa9z.svg)](https://asciinema.org/a/1pKbh06SlM1vu9g0OF68EJa9z?autoplay=1&t=3)
