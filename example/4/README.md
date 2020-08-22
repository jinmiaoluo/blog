# 我的 RSS 订阅习惯
通过 Newsboat(RSS 命令行客户端) 进行 RSS 订阅

#### 目录
<!-- vim-markdown-toc GitLab -->

* [如何使用本仓库](#如何使用本仓库)
* [安装命令](#安装命令)
* [基本操作](#基本操作)
* [我的浏览习惯](#我的浏览习惯)
* [注意事项](#注意事项)

<!-- vim-markdown-toc -->

#### 如何使用本仓库
1. 安装 newsboat
2. 将本仓库的 `urls` `config` `bookmark.sh` 文件拷贝到 newsboat 的配置目录下 (默认是 `~/.newsboat`)
3. 启动 newsboat 即可

#### 安装命令
Arch Linux
```bash
pacman -S newsboat
```

Ubuntu & Debian
```bash
apt install newsboat
```

MacOS
```bash
brew install newsboat
```

#### 基本操作
- `j` 向下移动
- `k` 向上移动
- `q` 返回
- `E` 修改或者编辑 `urls` 文件, 用于新增 RSS 记录或者删除 RSS 记录
- `o` 在浏览器里面打开订阅文章
- `O` 在浏览器里面打开订阅文章并标记为已读
- `N` 给订阅文章标记未读或已读
- `G` 在浏览器打开当前 RSS 频道内所有未读订阅文章
- `J` 下一个频道
- `K` 上一个频道
- `l` 显示没有新文章的频道(默认是只显示有新文章的频道)

#### 我的浏览习惯
1. 执行 `newsboat` 打开 feed 页
2. 等待 feed(一个 feed 一般就是一个网站) 抓取. 结束后 `j` `k` 导航到想要看的 feed. `enter` 进入 feed
3. 按 `O` 打开想读的文章并标记为已读. 如果想全部都打开并标记为已读. 会按 `G`. 如果所有的文章都没兴趣. 按 A 标记为已读而不打开. 如果有新的网站的 RSS 地址要添加. 按 `e` 调起编辑器. 将该网站的 RSS 地址黏贴到编辑器末尾新的一行(可以打上 [tag](https://wiki.archlinux.org/index.php/Newsboat#Tagging_feeds))并退出即可( Newsboat 会自动加载并抓起内容)
4. 按 `q` 退出 `newsboat`

#### 注意事项
- 命令行需要初始化 EDITOR 环境变量
    ```bash
    export EDITOR=vim # 或者其他你常用的编辑器
    ```
- newsboat 是一个命令行的工具, 因此会有许多快捷键, 打开 newsboat 后, 可以在任意页面, 按 `?` 键唤出帮助信息(通过键盘方向键上下浏览即可)
- `config` 默认给 MacOS 环境用的. 如果你是 Linux 桌面用户, 请修改 `config` 文件 `browser` 字段的值. 将 `open` 改为 `xdg-open`

