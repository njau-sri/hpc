# qsub

登陆节点仅用于任务提交管理和文件上传下载, 禁止在登陆节点终端直接输入命令进行计算. 高性能计算集群系统采用 Sun Grid Engine 软件调度任务, 支持脚本任务和终端任务两种计算任务.

### 任务脚本

适合运行时间较长的计算任务, 首先编写计算任务脚本 ([示例脚本](../qsub/)), 然后在登陆节点终端使用 qsub 命令提交任务:

    qsub myjob.sh

其中 myjob.sh 为任务脚本文件, 文件内容为:

```
#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

# your code goes here

date
```

任务脚本调用 `date` 命令显示当前日期和时间, 任务脚本中以 `#!`, `#$` 开头的行一般不需要修改, 以 `#` 开头的行为注释行.

需要注意脚本文件的换行符必须是单个 `LF` 字符 (\n, Linux, Mac OS X), 不支持 `CR+LF` (\r\n, Windows OS) 和 `CR` (\r, classic Mac OS) 格式的换行符, Linux 终端下可以使用 `vi` 命令查看文件并进行换行符转换:

    vi myjob.sh

然后直接依次输入以下两个命令并回车:

    :set fileformat=unix
    :wq

其中, `:set fileformat=unix` 是将换行符转换为 `LF` 类型, `:wq` 是保存文件并退出. 使用 `:set fileformat=dos` 可将换行符转换为 `CR+LF` 类型.

任务脚本提交后调度软件将分配任务编号, 终端输入 `qstat` 命令可查看任务状态, 输入 `qdel` 加任务编号可取消相应的计算任务.

### 终端任务

适合运行时间较短的计算任务, 在登陆节点终端直接使用 `qrsh` 命令申请计算任务终端, 然后才能输入相应的命令进行计算. 
