# 第六章

CS:APP 学习过程记录

文中的插图出自 Computer Systems: A Programmer's Perspective, 3/E (CS:APP3e). 版权归原作者所有.

#### 目录

<!-- vim-markdown-toc GFM -->

* [HDD 磁盘的组成结构](#hdd-磁盘的组成结构)
* [为什么需要区分逻辑块和物理块](#为什么需要区分逻辑块和物理块)
* [smartctl 如何查看磁盘的写入量](#smartctl-如何查看磁盘的写入量)
* [随机读取和顺序读取差异的原因](#随机读取和顺序读取差异的原因)
* [什么是时间局部性(temporal locality)和空间局部性(spatial locality)](#什么是时间局部性temporal-locality和空间局部性spatial-locality)
* [判断局部性好坏的方法](#判断局部性好坏的方法)
* [几种缓存失效](#几种缓存失效)
* [如何给你的磁盘测速的同时避免缓存干扰真实速度](#如何给你的磁盘测速的同时避免缓存干扰真实速度)
* [词汇汇总](#词汇汇总)
* [reference](#reference)

<!-- vim-markdown-toc -->

#### HDD 磁盘的组成结构

见视频: [bilibili: cmu csapp p11](https://www.bilibili.com/video/BV1iW411d7hd?p=11&t=0h12m02s)

#### 为什么需要区分逻辑块和物理块

因为磁盘存在 sector 损坏的可能. 需要通过逻辑块和物理块的映射, 从而避开损坏的 sector(扇区).

#### smartctl 如何查看磁盘的写入量

sector 的大小默认是 512 bytes. 在 `smartctl -a /dev/sdx` 中找到 `sector write count`, 二者乘积即为磁盘写入量.

#### 随机读取和顺序读取差异的原因

随机读取 page 需要做一次擦除, 预计需要 1ms 的时间, 所以比较慢. SSD 擦除是以 block 为单位的, 如果随机读取的只是 block 其中的一部分 page. 则剩下的 page 还要做一定的处理(时间成本)

#### 什么是时间局部性(temporal locality)和空间局部性(spatial locality)

- 时间局部性: 最近访问的地址或者数据或者指令可能会被再次访问. 优化思路, 将复杂逻辑简单化, 封装为简单函数后, 复用变量, 精简逻辑. 从而实现指令复用, 变量复用等.
- 空间局部性: 最近访问的地址附近的地址可能会被访问. 优化思路, 让被访问数据的地址尽可能紧凑和连续.

#### 判断局部性好坏的方法

- 被访问的数据地址是否连续紧凑.
- 是否复用了变量.
- 逻辑是否简单. 背后的指令实现是否是类似的(指令复用).

#### 几种缓存失效

- cold(compulsory) miss: 强制不命中. cache 刚开始使用的时候, cache 是空的(需要 warm up, 即热身).
- conflicts miss: 缓存冲突不命中. 由于缓存访问模式和映射算法, 缓存在载入时, 不同的数据被同时要求放入到缓存中相同的位置(这个位置是通过算法算出来的). 导致尽管缓存有足够的容量, 还是发生了缓存数据的驱逐和重新加载.
- capacity miss: 容量不命中. 由于数据太大了, 比如数组, cache 无法放下完整的数组中的数据.

#### 如何给你的磁盘测速的同时避免缓存干扰真实速度

写入速度:

```bash
dd if=/dev/zero of=tempfile bs=1M count=1024 conv=fdatasync,notrunc status=progress
# 1024+0 records in
# 1024+0 records out
# v bytes (w MB, x MiB) copied, y s, z MB/s
```

读取速度(不带缓存):

```bash
echo 3 > /proc/sys/vm/drop_caches # 这一行的解释见末尾
dd if=tempfile of=/dev/null bs=1M count=1024 status=progress
# 1024+0 records in
# 1024+0 records out
# v bytes (w MB, x MiB) copied, y s, z MB/s
```

读取速度(带缓存):

```bash
dd if=tempfile of=/dev/null bs=1M count=1024 status=progress
# 1024+0 records in
# 1024+0 records out
# v bytes (w MB, x MiB) copied, y s, z MB/s
```

清理临时文件

```bash
rm tempfile
```

下面是 linux 下如何在测试磁盘速度前避免磁盘缓存影响速度真实性的命令解释:

- Clear PageCache only. `sync; echo 1 > /proc/sys/vm/drop_caches`
- Clear dentries and inodes. `sync; echo 2 > /proc/sys/vm/drop_caches`
- Clear PageCache, dentries and inodes. `sync; echo 3 > /proc/sys/vm/drop_caches`
- `sync` will flush the file system buffer.

#### 词汇汇总
- RAM(Random-access memory): 随机存取存储器
- DRAM(Dynamic random-access memory): 动态随机存取存储器. 常见为: 内存
- SRAM(Static random-access memory): 静态随机存取存储器. 常见为: CPU 缓存, 内建在 CPU 内部
- Transistor: 晶体管. 这是实现 CPU RAM ROM 的基础
- ROM: 只读内存, 在制造过程中写入程序
- SLC: Single-Level Cell or SLC (1 bit per cell)
- MLC: Multi-Level Cell or MLC (2 bits per cell)
- TLC: Triple-Level Cell or TLC (3 bits per cell)
- QLC: Quad-Level Cell or QLC (4 bits per cell)
- PLC: Penta-Level Cell or PLC (5 bits per cell)
- PROM: 可编程的只读内存. 制造完成后, 可通过高电流熔断的方式写入程序, 而不是在制造过程中.
- EPROM: 可擦除编程的只读内存. 需要独立的一个设备才能实现擦除和编程.
- EEPROM(electrically erasable programmable read-only memory): 可电擦除编程的只读内存. 不需要独立的擦除和编程的设备. 可以直接通过印制电路板上编程
- BUS: 总线. PCI 总线是广播式的. 后来的 PCIe 其本质可以看成是加了一个开关(在特定时间点内只有部分特定 I/O 设备是跟总线完全连接的. 从而避免可能存在的总线上的数据被意外篡改)
- ALU(arithmetic logic unit ): 逻辑运算单元, 指令执行的地方, CPU 的组成部件之一
- track: 磁道
- sector: 扇区
- gaps: 间隔
- platter: 碟片
- spindle: 主轴
- cylinder: 柱面
- seek time: 寻道时间
- rotational time: 旋转等待时间
- DMA(Direct memory access): 直接内存访问. 比如从磁盘加载数据到内存.
- MMU(Memory Management Unit): 用于 CPU 实现内存虚拟地址到物理地址映射的转换.
- IOMMU(Input–Output Memory Management Unit): 用于连接具备直接访问内存能力的 I/O 总线设备到内存, 实现 I/O 设备直接访问内存的能力(本质上也是实现虚拟内存地址到物理地址映射的功能). 比如 PCIe 显卡的 graphics address remapping table(GART).
- GART(graphics address remapping table): 实现 PCIe 图形显卡直接访问内存. 而不需要经过 CPU.
- locality: 局部性
- dentries: is a data structure that represents a directory
- inodes: is a data structure that represents a file

#### reference
- [Memory Management Unit](https://en.wikipedia.org/wiki/Memory_management_unit)
