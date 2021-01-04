# GNU 构建系统工具用法

记录 `aclocal` `autoconf` `automake` `make` 的用法.

在官方的 FAQ 中, 有关于新手教程的教程资源. 开源项目建议要看看 FAQ. 如果 FAQ
没有解答你的疑惑, 再通过 Google 去找博客文章等. [FAQ
链接](https://www.gnu.org/software/automake/faq/autotools-faq.html#Getting-started)

Gentoo 关于 Autotools
的[文章](https://devmanual.gentoo.org/general-concepts/autotools/index.html)
建议看一下, 简洁明了.

automake 的仓库 doc 目录下有一个 amhello 的 demo. 可以根据
[文档](https://www.gnu.org/savannah-checkouts/gnu/automake/manual/automake.html#Creating-amhello)
跑一下. 命令行文档见:
```shell
info automake 'hello world'
```

在 FAQ 内还附上了官方的文档的链接. 官方文档会很详细. 见上面的 FAQ 链接.

这一份 [PPT](https://www.lrde.epita.fr/~adl/dl/autotools.pdf) 可以看一下.

# 2021-01-09 16:00

在前往深圳的高铁上. 距离到站还有 15 分钟. 利用这短暂的时间. 翻阅上面的 PDF.
必须称赞一下 Sony 的 WI-1000XM2 项圈耳机, 降噪让我减少了很多干扰.

# 2021-01-12 11:49

关于这份 [PPT](https://www.lrde.epita.fr/~adl/dl/autotools.pdf).

最近用零碎的休息时间看了前面的 255 页. 这份 PPT 很好.  它好在:
非常简洁明了的介绍了 GNU autotools 的作用, 整个流程是如何执行的, 基本的 M4
语言的作用和语法. 看完前面 255 页, 我能看懂一部分 curl M4 文件夹中的内容了.
如果你也想了解 GNU autotools 的用法, 比如 Automake Autoconf, 从这份 PPT 开始,
耐心一点(它有 500 多页), 慢慢看, 你会弄懂的.

# 2021-01-12 14:20

花了一杯咖啡的时间. 看到了 327 页.
[PPT](https://www.lrde.epita.fr/~adl/dl/autotools.pdf) 围绕 M4 语法和 Autoconf
中的 Macros, 介绍了更多 Autoconf 中的常见用法. 可以看懂一部分 curl configure.ac
文件的 M4sh 了. 另外, 关于 M4 语法的引号和 Autoconf 中的中括号的作用. PPT
中的解释很好.

# 2021-01-13 14:15

看到了 367 页. 介绍了如何用条件判断, 如何构建库和程序, 如何指定静态/动态库,
build tree 和 source tree 的区别, 文件夹层级.

# 2021-01-14 14:11

看到了 396 页. 介绍了如果 make 不能维护 Automake Autoconf 中的脚本时,
如何重新生成构建需要的脚本. 介绍了如何写自己的 Macro.

# 2021-01-15 13:52

看到 448 页. 开始介绍如何管理/检查/打包动态库.

# 2021-01-25 14:08

看到 493 页, 关于 I18n 和 L10n 的内容.

# 2021-01-28 14:09

看到 512 页, 前面主要是关于 I18n 的. 也就是如何在代码中实现多语言.
后面的内容是关于 L10n 的问题. 我们在代码库中实现了 I18n, 需要有基本的数据,
用于提供不同的语言的数据. 比如用户可以看到的标准输出信息的其他语言版本. 这就是
L10n 解决的问题.

# 2021-01-29 16:17

看到 548 页, 前面是关于如何实现 L10n 的. 比如多语言 po 文件. 另外, 命令行的程序,
如果需要显示中文/英文/日文, 可以配置 LANGUAGE 环境变量为
`en_US.UTF-8/zh_CN.UTF-8/ja_JP.UTF-8`.

# 2021-02-05 13:53

看完这份 [PPT](https://www.lrde.epita.fr/~adl/dl/autotools.pdf) 了.
