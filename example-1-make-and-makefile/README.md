# Makefile
Makefile 是告诉 make 这个工具如何编译和链接应用程序的文件. 自动化工具.

文中涉及到的 `Makefile` 开头的文件, 建议打开文件查看, 文中将包含作用的备注, 和执行后的输出. 另外, 请在一个 `terminal` 窗口内执行一下, 查看具体的效果.

#### Makefile 格式
```
target: prerequisites
	recipe
	...
```

`target` 目标. 在满足 `prerequisites` 条件下, 用于指定执行 `recipe` 后生成的结果文件的名字. 如果 `target` 指定的文件存在, 且比 `prerequisites` 要新. 则 `recipe` 不会被执行.

`recipe` 清单. 是一些 shell 脚本. 就是动作. 如何处理源码文件生成 `target` 中指定的文件.

`prerequisites` 准备条件. 是一些源码文件或者其他 `target`.

`recipe` 必须以指定的开头符号开头. 比如默认的是 `tab` 开头. 所以每条 `recipe` 需要用 `tab` 开头.


#### `Target` 和 `Phony Target` 假目标
`target` 常用于指定 make 命令的参数. 比如 `make all`.

`phony target` 用于避免文件名和 `target` 名冲突导致的 `recipe` 不执行问题. 见官方文档: [4.6 Phony Targets](https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html).

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
默认(执行 `make` 不带任何参数)以第一个不是`.`开头的 `target` 开始执行. 这个 `target` 被称为 `goal`. Makefile  最终目的是完成 `goal` 指定的行为.

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

`all` 这个`goal` 由 `fmt` `build` 这两个 `target` 组成. `build` 这个 `target` 又 由 `frps` 和 `frpc` 这两个 `target` 组成, 所以最后执行的事情就是执行 fmt frps frpc 中的 `recipe` 规则了.

#### `@Command` 用法
> When @ is used at the very beginning of a recipe (command) line, just after
> the tab character, it causes the command not to be printed when it's about to
> be executed.

`@` 放在 `recipe` 开始符号后面, 其他 `recipe` 命令前面. 表示不要打印将要执行的命令.

具体的效果可以看看 `Makefile.RecipeEchoing` 中的备注, 另外可以执行下面的命令查看效果:

```bash
make -f Makefile.RecipeEchoing
```

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

`hugo-build` target consists of a recipe and some prerequisites. the order is prerequisites first, and then execute recipe.

#### `$$` 的作用

在 Makefile 有时会看到 `$$` 开头的用法, 比如 `$${var}`, 因为 `$` 在 Makefile 内有特殊含义, 因此 `$${var}` 表示的其实是 shell 环境下的 `${var}`, 即 shell 脚本调用变量的意思.

`$$()` 同理. 表示的是 shell 环境下的 `$()`. 即捕获 shell 脚本的返回值作为结果的字符串的意思.

见 demo 结果和里面的备注:

```bash
export variable=123
make -f Makefile.DoubleDollarSign
```

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

在 demo 里面, protoc_middleman_go 这个 `prerequisite` 被同时依赖, 为了避免重复执行我们有 `touch protoc_middleman_go`, 目的是通过创建 `target` 同名文件(或者更新文件的时间戳), 避免 `recipe` 被重复执行. 所以最终执行的命令如下:

```bash
mkdir -p tutorial # make directory for go package
protoc $PROTO_PATH --go_out=tutorial addressbook.proto
touch protoc_middleman_go
go build -o add_person_go add_person.go
go build -o list_people_go list_people.go
```

相关的原理见官方文档: [4.6 Phony Targets](https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html)

#### `target::` 的作用

在 `target` 后面跟了两个 `:` 号.

```make
Newprog :: foo.c
	$(CC) $(CFLAGS) $< -o $@
Newprog :: bar.c
	$(CC) $(CFLAGS) $< -o $@
```

如果"foo.c"文件被修改,执行make以后将根据"foo.c"文件重建目标"Newprog".而如果"bar.c"被修改那么"Newprog"将根据"bar.c"被重建.如果以上两个规则为普通规时出现的情况是什么?（make将会出错并提示错误信息）

当同一个目标出现在多个双冒号规则中时,规则的执行顺序和普通规则的执行顺序一样,按照其在Makefile中的书写顺序执行.

GNU make的双冒号规则给我们提供一种根据依赖的更新情况而执行不同的命令来重建同一目标的机制.一般这种需要的情况很少,所以双冒号规则的使用比较罕见.一般双冒号规则都需要定义命令,如果一个双冒号规则没有定义命令,在执行规则时将为其目标自动查找隐含规则.

具体的效果可以看看 `Makefile.DoubleColon01` 和 `Makefile.DoubleColon02` 中的备注, 另外可以执行下面的命令查看效果:

```bash
# 功能1: 允许同名 goal
make -f Makefile.DoubleColon01

# 作为模式匹配的默认值
make -f Makefile.DoubleColon02
make -f Makefile.DoubleColon02 1
make -f Makefile.DoubleColon02 2
```

#### 自动化变量
- `$@`

The file name of the target of the rule. If the target is an archive member, then ‘$@’ is the name of the archive file. In a pattern rule that has multiple targets (see Introduction to Pattern Rules), ‘$@’ is the name of whichever target caused the rule’s recipe to be run.

代表规则中的目标文件名。如果目标是一个文档（Linux中，一般称.a文件为文档），那么它代表这个文档的文件名。在多目标的模式规则中，它代表的是哪个触发规则被执行的目标文件名。

- `$^`

The names of all the prerequisites, with spaces between them. For prerequisites which are archive members, only the named member is used (see Archives). A target has only one prerequisite on each other file it depends on, no matter how many times each file is listed as a prerequisite. So if you list a prerequisite more than once for a target, the value of `\$^` contains just one copy of the name. This list does not contain any of the order-only prerequisites; for those see the `$|` variable, below.

规则的所有依赖文件列表，使用空格分隔。如果目标是静态库文件名，它所代表的只能是所有库成员（.o文件）名。一个文件可重复的出现在目标的依赖中，变量“$^”只记录它的一次引用情况。就是说变量“$^”会去掉重复的依赖文件。

- `$<`

规则的第一个依赖文件名。如果是隐含规则，则它代表通过目标指定的第一个依赖文件。

具体的效果可以看看 `Makefile.AutomaticVariables` 中的备注, 另外可以执行下面的命令查看效果:

```bash
make -f Makefile.AutomaticVariables
```

#### `% 模式匹配规则`

例子:
```make
all::

%: common-% ;

.PHONY: common-all
common-all: precheck style test

.PHONY: common-style
common-style:
	@echo ">> checking common code style"

.PHONY: style
style:
	@echo ">> checking code style"

.PHONY: precheck
precheck:
	@echo ">> prechecking"

.PHONY: common-precheck
common-precheck:
	@echo ">> common prechecking"

.PHONY: common-test
common-test:
	@echo ">> common testing"

# output:
#  >> prechecking
#  >> checking code style
#  >> common testing
```

- `all::` 是一个双冒号 `goal`, 用于传给 `%: common-% ;` 这个模式匹配规则作为默认值.
- `%: common-% ;` 是 `pattern match`(模式匹配规则), 用于匹配 `goal`.

具体的优先级, 可以看看 `Makefile.PatternMatch` 中的备注, 另外可以执行下面的命令查看效果:

```bash
make -f Makefile.PatternMatch
```

#### 变量

- 传统的做法是变量用大写字母.
- 对于内部变量, 用小写字母.(比如准备条件中的多个文件, 多个目标).

见 demo 文件中的备注:

```bash
make -f Makefile.Variables
```

#### 多个目标作为构建结果的情况

```bash
make -f Makefile.Variables 5
make -f Makefile.Variables 6
```

#### 有条件指令

```bash
make -f Makefile.ConditionDirective
```

#### 函数

函数调用类似于变量调用. 函数调用会在函数名和参数间用空格隔开.

```bash
make -f Makefile.Functions
```

#### 参考
- [「番外」请入门 Makefile-煎鱼](https://eddycjy.com/posts/go/gin/2018-08-26-makefile/)
- [从简单实例开始，学会写Makefile（一）](http://blog.fatedier.com/2014/09/08/learn-to-write-makefile-01/)
- [从简单实例开始，学会写Makefile（二）](http://blog.fatedier.com/2014/09/24/learn-to-write-makefile-02/)
- [GNU Make 中文文档](http://free-online-ebooks.appspot.com/tools/gnu-make-cn/)
- [GNU Make 官方文档](https://www.gnu.org/software/make/manual/html_node)
