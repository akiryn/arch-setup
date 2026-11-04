未整理，以零散知识点和关键词速查为主，并非是完全是bashscript语法




```bash
if [ -z "$COORDS" ]; then
    exit 0
fi
```
- `-z`：字符串长度为 0 时返回真（退出状态码为 0）。
- `-n`：字符串长度不为 0 时返回真。
- `!`：对判断结果取反。

`[[ -d "dotfiles" ]]` 检查源码里是否有 `dotfiles` 目录。




```bash
set -euo pipefail
```
Bash 脚本中常用的“严格模式”组合，用于让脚本在遇到错误时尽早失败，而不是静默继续执行。
`set -e`（errexit）：命令失败即退出
`set -u`（nounset）：使用未定义变量即报错
`set -o pipefail`：管道中任一环节失败即算失败

`pipefail` 是 Bash（以及部分其他 shell，如 ksh、新版 POSIX sh）的扩展选项，**不是所有 `sh` 都支持**。


```bash
pkill -USR2 -x waybar
```
- **`-USR2`**：指定发送的信号为 `SIGUSR2`。Waybar 将该信号定义为“重载（Reload）”信号，收到后会原地重建状态栏，应用新的 `config` 和 `style.css` 修改，且不会丢失其在屏幕上的位置。
- **`-x`**：要求**精确匹配**进程名。这能防止误杀名称中包含 “waybar” 的其他无关进程（例如名为 `waybar-helper` 的进程）。

```bash
: ${_sccache:=}
```
**`${变量:=默认值}`** 表示，如果变量**未设置或值为空**，就把默认值赋给变量，然后展开为该值。如果变量已有非空值，就保留并展开原值。这里 `:=` 后面没有内容，所以默认值是**空字符串**。

