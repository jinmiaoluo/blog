# Makefile
makefile 是告诉 make 这个工具如何编译和链接应用程序的文件. 自动化工具

## 目录

<!-- vim-markdown-toc GFM -->

* [Makefile 格式](#makefile-格式)
* [`Target` 和 `Phony Target` 假目标](#target-和-phony-target-假目标)
* [`make` 的执行顺序](#make-的执行顺序)
* [`goal` 的调用](#goal-的调用)
* [`@Command` 用法](#command-用法)
* [`target` 下 `prerequisites` 和 `recipe` 的执行顺序](#target-下-prerequisites-和-recipe-的执行顺序)
* [`$$Variable` 的作用](#variable-的作用)
* [如何避免 `target` 被重复执行](#如何避免-target-被重复执行)
* [参考](#参考)

<!-- vim-markdown-toc -->

#### Makefile 格式
```
target: prerequisites
	recipe
	...
```

`target` 目标. 在满足 `prerequisites` 条件下, 用于指定执行 `recipe` 后生成的结果文件的名字. 如果 `target` 指定的文件存在, 且比 `prerequisites` 要新. 则 `recipe` 不会被执行

`recipe` 清单. 是一些 shell 脚本. 就是动作. 如何处理源码文件生成 `target` 中指定的文件

`prerequisites` 准备条件. 是一些源码文件或者其他 `target`

`recipe` 必须以指定的开头符号开头. 比如默认的是 `tab` 开头. 所以每条 `recipe` 需要用 `tab` 开头


#### `Target` 和 `Phony Target` 假目标
`target` 常用于指定 make 命令的参数. 比如 `make all`

`phony target` 用于避免文件名和 `target` 名冲突导致的 `recipe` 不执行问题. 见官方文档: [4.6 Phony Targets](https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html)

示例(不含`phony target`):
```make
all: fmt build

fmt:
	go fmt ./...

build: frps frpc

frps:
	go build -o bin/frps ./cmd/frps
	@cp -rf ./assets/static ./bin

frpc:
	go build -o bin/frpc ./cmd/frpc
```


#### `make` 的执行顺序
默认(执行 `make` 不带任何参数)以第一个不是`.`开头的 `target` 开始执行. 这个 `target` 被称为 `goal`. Makefile  最终目的是完成 `goal` 指定的行为

#### `goal` 的调用
`goal` 是由其他 `target` 组成的 `target`. 比如:

```make
all: fmt build

fmt:
	go fmt ./...

build: frps frpc

frps:
	go build -o bin/frps ./cmd/frps
	@cp -rf ./assets/static ./bin

frpc:
	go build -o bin/frpc ./cmd/frpc
```

`goal` 由 `fmt` `build` 这两个 `target` 组成. `build` 这个 `target` 又 由 `frps` 和 `frpc` 组成, 所以最后执行的事情就是执行 fmt frps frpc 中的 `recipe` 规则了

#### `@Command` 用法
> When @ is used at the very beginning of a recipe (command) line, just after
> the tab character, it causes the command not to be printed when it's about to
> be executed.

`@` 放在 `recipe` 开始符号后面, 其他 `recipe` 命令前面. 表示忽略输出

#### `target` 下 `prerequisites` 和 `recipe` 的执行顺序
```
.PHONY: default clean hugo hugo-build

default: hugo

clean:
	rm -rf public/


hugo-build: clean hugo-themes
	hugo --enableGitInfo --source .

hugo:
	hugo server --disableFastRender --enableGitInfo --watch --source .
	# hugo server -D

hugo-themes:
	rm -rf themes
	mkdir themes
	git clone --depth=1 https://github.com/matcornic/hugo-theme-learn.git themes/hugo-theme-learn
	rm -rf themes/hugo-theme-learn/.git
```

`hugo-build` target consists of a recipe and some prerequisites. the order is prerequisites first, and then execute recipe

#### `$$Variable` 的作用
在 Makefile 有时会看到 `$$` 开头的变量, 因为 `$` 在 Makefile 内有特殊含义, 因此 `$$Variable` 表示的其实是 Bash 环境下的 `$Variable`, 即 bash 脚本调用环境变量的意思

#### 如何避免 `target` 被重复执行

情形如下:
```make
go:     add_person_go     list_people_go
add_person_go: add_person.go protoc_middleman_go
	go build -o add_person_go add_person.go
list_people_go: list_people.go protoc_middleman_go
	go build -o list_people_go list_people.go
protoc_middleman_go: addressbook.proto
	mkdir -p tutorial # make directory for go package
	protoc $$PROTO_PATH --go_out=tutorial addressbook.proto
	@touch protoc_middleman_go
```

在 demo 里面, protoc_middleman_go 这个 `prerequisite` 被同时依赖, 为了避免重复执行我们有 `touch protoc_middleman_go`, 目的是通过创建 `target` 同名文件, 避免 `recipe` 被重复执行. 所以最终执行的命令如下:

```bash
mkdir -p tutorial # make directory for go package
protoc $PROTO_PATH --go_out=tutorial addressbook.proto
touch protoc_middleman_go
go build -o add_person_go add_person.go
go build -o list_people_go list_people.go
```

相关的原理见官方文档: [4.6 Phony Targets](https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html)

#### 参考
- [「番外」请入门 Makefile-煎鱼](https://eddycjy.com/posts/go/gin/2018-08-26-makefile/)
- [从简单实例开始，学会写Makefile（一）](http://blog.fatedier.com/2014/09/08/learn-to-write-makefile-01/)
- [从简单实例开始，学会写Makefile（二）](http://blog.fatedier.com/2014/09/24/learn-to-write-makefile-02/)
