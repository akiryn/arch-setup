主要为Arch Linux + Niri + Wayland下配置kitty+zsh+starship，其他内容仅作相关介绍
- 建议自行了解一下TTY、终端、Shell、Shell脚本区别
- 对于Shell我主要使用zsh+安装独立插件自行管理的方式，本文也介绍了通过Oh My Zsh框架管理

## 终端模拟器
### kitty
1. 安装

```zsh
sudo pacman -S kitty
mkdir -p ~/.config/kitty/
vim ~/.config/kitty/kitty.conf
```
2. 配置

```zsh
vim ~/.config/kitty/kitty.conf
# 添加以下内容
```

我的配置：[kitty.conf](../config/kitty/)，我总结的kitty使用说明：[kitty配置](kitty配置.md)

3. 美化

这里以已经加入预设的Catppuccin-Mocha为例，通过kitten themes工具配置，选择后立即生效

```zsh
# 终端执行
kitten themes
```

美化配置原理：将颜色相关配置写入一个文件，kitty.conf中通过include引入。

```zsh
# BEGIN_KITTY_THEME
# Catppuccin-Mocha
include current-theme.conf
# END_KITTY_THEME
```

这里给出[current-theme.conf](../config/kitty/current-theme.conf)参考，可以直接将其复制到~/.config/kitty/下然后在kitty.conf引入。关于kitten themes使用见[官网说明](https://sw.kovidgoyal.net/kitty/kittens_intro/?utm_source=chatgpt.com)

## starship提示符美化
<https://starship.rs/>

1. 安装 Nerd 字体和 Starship

```zsh
sudo pacman -S ttf-jetbrains-mono-nerd starship
```

2. 编辑所使用shell的配置文件使其使用Starship

```zsh
vim ~/.zshrc
#添加
# Starship prompt (managed by pacman).
eval "$(starship init zsh)"
```

3. 美化提示符

```zsh
vim ~/.config/starship.toml
#添加
```
我的配置：[starship](../config/starship/starship.toml)

也可以用官方提供的一些预设：<https://starship.rs/presets/>。

4. 重启终端


## Shell配置
**本文主要讲述zsh相关配置**

| 对比项       | Bash                    | Zsh                          | Fish                                    |
| --------- | ----------------------- | ---------------------------- | --------------------------------------- |
| 定位        | 通用 Shell、脚本执行           | 高度可定制的交互 Shell               | 现代化、用户友好的交互 Shell                       |
| 优点        | 兼容性强、稳定、普及率高、脚本生态成熟     | 插件丰富、高度可定制、兼容多数 Bash 使用习惯    | 开箱即用、自动补全、语法高亮、智能历史记录、交互体验优秀            |
| 缺点        | 默认交互体验一般，需手动配置补全、提示符等功能 | 配置相对复杂，插件过多可能拖慢启动速度          | 不兼容 POSIX Shell 语法，部分 Bash/Zsh 配置无法直接使用 |
| POSIX 兼容性 | 高，可通过 POSIX 模式提高兼容性     | 高，支持 POSIX 模式，但默认并非完全兼容      | 不兼容                                     |
| 自动补全      | 基础支持，可通过插件增强            | 功能强大，可高度定制                   | 默认提供智能补全与建议                             |
| 插件生态      | 丰富                      | 非常丰富，支持 Oh My Zsh 等框架        | 相对较小，支持 Fisher 等插件管理器                   |
| 配置难度      | 低～中                     | 中～高                          | 低                                       |
| 启动速度      | 通常较快                    | 取决于插件和配置                     | 通常较快                                    |
| Shell 脚本  | 非常适合                    | 支持，但通用脚本通常优先使用 Bash/POSIX sh | 不推荐用于通用 Shell 脚本                        |
| 适合人群      | 服务器管理、脚本开发、追求兼容性的用户     | 喜欢个性化配置、插件生态的用户              | 希望开箱即用、注重交互体验的用户                        |

选择建议
- Bash：适合系统管理和 Shell 脚本开发，兼容性最好，但默认交互体验值得优化。
- Zsh：适合追求高度定制的 Linux 桌面用户，搭配 Oh My Zsh、Powerlevel10k 等工具可获得优秀的交互体验。
- Fish：适合不愿花费大量时间配置 Shell 的用户，默认体验优秀，但不适合直接运行 Bash/POSIX Shell 脚本。

### zsh
<https://zsh.sourceforge.io/>
1. 安装zsh，插件

```bash
sudo pacman -S zsh
chsh -s /usr/bin/zsh
sudo pacman -S zsh-syntax-highlighting zsh-autosuggestions zsh-completions
```

- zsh-syntax-highlighting高亮，
- zsh-autosuggestions根据历史记录显示灰色建议
- zsh-completions按Tab时显示这里有哪些合法选项
2. 配置文件
Zsh 配置文件本质上是 Shell 脚本，下方知识点总结会介绍一些用到的shell脚本语法
我的配置：[.zshrc](../config/zsh/.zshrc)

### zsh相关的知识(较杂乱)
#### 区分登录 Shell、交互式 Shell 和非交互式 Shell
##### 1. 登录 Shell（Login Shell）

登录 Shell 的主要特点是执行登录阶段的初始化配置。

例如：

```
zsh -l
```

`-l` 表示以登录 Shell 模式启动 Zsh。

它可以读取 `.zprofile` 中配置的登录环境设置。

但登录 Shell 不一定是交互式的，例如：

```
zsh -lc 'echo hello'
```

这条命令会启动一个登录、非交互式的 Zsh，执行 `echo hello` 后退出。

##### 2. 交互式 Shell（Interactive Shell）

交互式 Shell 主要用于人与命令行直接交互。

例如：

```
zsh -i
```

`-i` 强制开启交互模式。

交互式 Shell 提供的能力包括：

- 命令行编辑
    
- 历史记录搜索
    
- Tab 自动补全
    
- 输入建议
    
- 提示符显示
    

这些功能主要由 Zsh 自身及其配置、插件提供。

##### 3. 非交互式 Shell（Non-interactive Shell）

典型例子：

```
zsh -c 'echo hello'
```

或者执行包含以下首行的脚本：

```
#!/usr/bin/env zsh
```

非交互式 Shell 不需要显示提示符，也不需要处理用户按 Tab、方向键等交互操作。

因此，通常没有必要在这种环境下初始化 Starship、fzf 快捷键和语法高亮插件。

#### Zsh 的五种用户启动文件
Zsh 使用不同的启动文件管理不同阶段的配置。

| 配置文件                              | 读取条件                    | 主要用途          |
| --------------------------------- | ----------------------- | ------------- |
| `~/.zshenv`，`/etc/zshenv`         | 几乎所有 Zsh 启动             | 必要的环境变量       |
| `~/.zprofile`，`/etc/zsh/zprofile` | 登录 Shell                | 登录环境初始化       |
| `~/.zshrc`，`/etc/zshrc`           | 交互式 Shell               | 补全、插件、快捷键、提示符 |
| `~/.zlogin`                       | 登录 Shell，且在 `.zshrc` 之后 | 登录完成后的操作      |
| `~/.zlogout`                      | 登录 Shell 正常退出时          | 退出登录的清理操作     |

其中最重要的是前三个。
登录交互式：.zshenv->.zprofile->.zshrc->.zlogin
非登录交互式：.zshenv->.zshrc
登录非交互式：.zshenv->.zprofile->.zlogin
非登录非交互式：.zshenv

#### 用到的shell语法

|语法|核心作用|常见使用场景|
|---|---|---|
|`source`|在当前 Shell 执行文件|加载插件和其他配置|
|`export`|将变量传递给子进程|设置环境变量|
|`setopt`|开启 Zsh 的选项|历史记录、补全行为|
|`autoload`|延迟加载函数|初始化补全系统|
|`eval`|将字符串解析为 Shell 代码并执行|初始化 Starship、zoxide|
|`$(...)`|执行命令并获取其输出|动态生成配置|
|`<(...)`|将命令输出提供为文件路径|比较两个命令的输出|
##### setopt
`setopt` 是 Zsh 的内建命令，用于启用 Shell 选项。

基本语法：

```
setopt 选项名
```

关闭选项：

```
unsetopt 选项名
```

|选项|作用|
|---|---|
|`AUTO_CD`|输入目录路径时自动切换目录|
|`HIST_IGNORE_DUPS`|连续相同的历史命令只保留一条|
|`HIST_IGNORE_SPACE`|不将以空格开头的命令加入历史记录|
|`SHARE_HISTORY`|在多个 Zsh 会话之间共享历史|
|`EXTENDED_GLOB`|启用扩展文件名匹配语法|
|`AUTO_PUSHD`|使用 `cd` 切换目录时将旧目录加入目录栈|

注意，`HIST_IGNORE_SPACE` 不是安全保密机制，也不能保证命令不会被其他日志系统记录。

列出当前开启的选项。

```
setopt
```

筛选历史记录相关选项。

```
setopt | grep -i hist
```


注意： `setopt` 设置一般只影响当前 Shell 及其后续启动时可继承的环境行为，不会自动写入 `.zshrc`。

要持久化设置，需要将相应命令写进配置文件。




##### autoload

`autoload`：按需加载函数，这是 Zsh 补全系统中非常重要的机制。
配置使用 `zsh-completions`，而 Zsh 的补全系统通常需要 `compinit` 初始化。

典型配置：
```
autoload -Uz compinit
compinit
```
- 为什么不直接`source compinit`？
因为 `compinit` 通常是一个可以通过 Zsh 函数搜索路径 `fpath` 找到的函数文件。

`autoload` 告诉 Zsh：这个函数可以在需要时从 `fpath` 加载。

它不会立即执行函数主体。

- 拆解参数

```
autoload -Uz compinit
```

|部分|含义|
|---|---|
|`autoload`|标记函数为自动加载|
|`-U`|加载函数时不进行别名展开|
|`-z`|使用 Zsh 风格加载函数|
|`compinit`|要自动加载的函数名称|

随后：

```
compinit
```

才会实际加载并执行补全系统初始化函数。
- 实验

查看函数搜索路径：

```
print -l $fpath
```

查找 `compinit`：

```
whence -v compinit
```

查看函数定义来源：

```
print -l $fpath | while read -r dir; do
    [[ -f "$dir/compinit" ]] && print -r -- "$dir/compinit"
done
```

`fpath` 类似于 `PATH`，但用途不同：

- `PATH`：搜索外部可执行命令。
    
- `fpath`：搜索 Zsh 函数定义文件。

#### 历史记录系统
`SHARE_HISTORY`：共享历史
`HIST_IGNORE_ALL_DUPS`：历史去重
`HIST_IGNORE_SPACE`：过滤历史
`history` 和 `fc` 的关系：在 Zsh 中，`history` 通常是 `fc -l` 的预定义别名。`fc` 是 Zsh 用于历史记录列出、编辑和重新执行的内建命令。
`常用命令`

|命令|作用|
|---|---|
|`history`|列出近期历史|
|`history 1`|从历史事件编号 1 开始列出|
|`fc -l -10`|列出最近 10 条|
|`fc -ln -10`|列出最近 10 条，不显示事件编号|
|`fc -R`|从历史文件读取记录|
|`fc -W`|将历史列表写入文件|
|`fc -A`|将新历史追加到文件|

Zsh 还支持历史展开（History Expansion），可以通过特殊语法引用以前执行的命令。

|语法|含义|
|---|---|
|`!!`|上一条历史命令|
|`!n`|历史事件编号 n|
|`!-2`|当前历史位置之前的第二条|
|`!git`|最近一条以 `git` 开头的命令|
|`!?status?`|最近一条包含 `status` 的命令|
|`!$`|上一条命令的最后一个参数|
|`!*`|上一条命令的全部参数（不含命令名）|
如果你只想查看展开结果而不执行，可以使用 `:p` 修饰符：

```
!!:p
```

注意： `!` 历史展开可能导致意外执行旧命令，特别是结合 `sudo` 时。学习阶段建议优先使用 `:p` 预览。

另外我配置了fzf替代zsh原生ctrl+r的搜索功能

|对比|Zsh 原生历史搜索|fzf 历史搜索|
|---|---|---|
|是否依赖外部工具|否|是|
|搜索方式|前缀、增量搜索等|模糊匹配|
|结果展示|通常在命令行中|交互式候选列表|
|适合场景|快速回溯命令|搜索大量历史记录|
#### Tab 补全、自动建议与模糊搜索
- Tab补全：按 Tab 后，Zsh 根据当前命令的补全规则提供候选项。
- 自动建议：输入过程中，插件可能根据历史记录自动显示剩余部分。
- fzf模糊搜索：主动打开搜索界面，根据输入内容筛选候选结果。示意界面，不代表实际匹配顺序。

`zsh-completions`并不是另一个补全引擎，而是提供更多的补全函数

例如：

```
Zsh 补全系统
    ├── Zsh 自带的补全函数
    ├── 软件包提供的补全函数
    └── zsh-completions 提供的额外补全函数
```

`zsh-autosuggestions`：历史输入建议


Zsh 内部有一个重要组件：

ZLE（Zsh Line Editor），即 Zsh 命令行编辑器。

ZLE 负责处理交互式命令行中的按键、光标移动和文本编辑。

zsh-autosuggestions 通过与 ZLE 集成，在输入变化时计算建议并显示。

它不需要替换 Zsh 的历史存储系统。


#### fzf
[fzf使用](终端相关小工具使用#fzf)

#### zoxide
[zoxide使用](终端相关小工具使用#zoxide)

#### 命令行编辑与快捷键
Zsh 的命令行编辑由 ZLE（Zsh Line Editor）负责，`bindkey` 决定按键执行什么操作，`bindkey -e` 决定使用哪套基础编辑键位。

在终端中，在按 Enter 执行命令之前，输入文字、移动光标、删除内容、搜索历史等操作，主要由 ZLE 处理。

kitty终端接收键盘输入->ZLE行编辑器

这里有三个概念：

|概念|作用|示例|
|---|---|---|
|ZLE|命令行编辑系统|管理输入缓冲区|
|Widget|一项编辑操作|`backward-char`|
|`bindkey`|将按键映射到 Widget|`bindkey '^A' beginning-of-line`|

Widget 可以理解为 ZLE 提供的可调用编辑动作。

##### Emacs 与 Vi 两种编辑模式
这是 Zsh 支持的两套主要的编辑键位体系

###### Emacs模式下常用的快捷键
要在.zshrc内指定`bindkey -e`
- 光标移动

| 快捷键      | 功能       |
| -------- | -------- |
| `Ctrl+A` | 移动到行首    |
| `Ctrl+E` | 移动到行尾    |
| `Ctrl+B` | 向左移动一个字符 |
| `Ctrl+F` | 向右移动一个字符 |
| `Alt+B`  | 向左移动一个单词 |
| `Alt+F`  | 向右移动一个单词 |

- 修改与删除

| 快捷键        | 功能                    |
| ---------- | --------------------- |
| `Ctrl+U`   | 删除光标到行首的内容            |
| `Ctrl+K`   | 删除光标到行尾的内容            |
| `Ctrl+W`   | 删除光标前的一个单词区域          |
| `Alt+D`    | 删除光标后的一个单词            |
| `Ctrl+Y`   | 粘贴最近一次通过 ZLE 删除的内容    |
| `Ctrl+/`   | 撤销编辑（实际键序列可能不同）       |
| `Ctrl + H` | 删除一个字符(相当于 Backspace) |
- 历史和补全

|快捷键|Zsh 原生典型行为|你的当前配置|
|---|---|---|
|`Ctrl+P`|上一条历史|通常保留|
|`Ctrl+N`|下一条历史|通常保留|
|`Ctrl+R`|增量反向历史搜索|fzf 历史搜索|
|`Tab`|命令补全|fzf 补全 Widget|
|`Ctrl+T`|交换相邻字符|fzf 文件选择|

因此，同一个快捷键的行为取决于最终生效的绑定，而不是仅由 `bindkey -e` 决定。

- bindkey 的用法
`查询按键绑定`例如：

```
bindkey '^A'
bindkey '^E'
bindkey '^R'
bindkey '^I'
```

可能得到：

```
"^A" beginning-of-line
"^E" end-of-line
"^R" fzf-history-widget
"^I" fzf-completion
```

`查看所有绑定`

```
bindkey
```

输出可能很长。

只查看当前 Emacs 键位表：

```
bindkey -M emacs
```

查看当前主键位表：

```
bindkey -M main
```

这里的 `main` 是 ZLE 当前使用的主键位映射入口。

`自定义按键`

例如把 `Ctrl+G` 绑定为清空当前输入行：

```
bindkey '^G' kill-whole-line
```

这是临时设置，只影响当前 Shell。

如果要永久生效，才需要写入 `.zshrc`。

但不建议随意覆盖已有快捷键，尤其是 `Ctrl+C`、`Ctrl+R`、Tab 等常用按键。

###### vi模式下常用的快捷键
- 光标移动

|按键|作用|
|---|---|
|`h`|左移一个字符|
|`l`|右移一个字符|
|`w`|移动到下一个单词开头|
|`b`|移动到前一个单词开头|
|`e`|移动到当前或下一个单词末尾|
|`0`|移动到行首|
|`^`|移动到第一个非空白字符|
|`$`|移动到行尾|
|`f<char>`|向右查找字符|
|`F<char>`|向左查找字符|
|`t<char>`|移动到目标字符之前|
|`;`|重复最近一次字符查找|
|`,`|反方向重复字符查找|

- 插入和替换

|按键|作用|
|---|---|
|`i`|在光标前插入|
|`a`|在光标后插入|
|`I`|在行首第一个非空白字符前插入|
|`A`|在行尾追加|
|`R`|进入替换模式|
|`r<char>`|替换当前字符|

- 修改与删除

|按键|作用|
|---|---|
|`x`|删除当前字符|
|`dw`|删除到下一个单词边界|
|`db`|向前删除一个单词范围|
|`d$`|删除到行尾|
|`dd`|删除当前命令行|
|`cw`|修改到单词边界并进入插入模式|
|`cc`|修改整行并进入插入模式|
|`C`|修改光标到行尾|
|`D`|删除光标到行尾|

- 撤销、重复和粘贴

| 按键       | 作用               |
| -------- | ---------------- |
| `u`      | 撤销最近编辑           |
| `Ctrl+R` | 在 Vi 普通模式下通常用于重做 |
| `.`      | 重复上一次编辑操作        |
| `p`      | 在光标后粘贴删除或复制的内容   |
| `P`      | 在光标前粘贴           |
| `yy`     | 复制当前命令行          |

- 历史记录搜索

|按键|功能|
|---|---|
|`k`|上一条历史命令|
|`j`|下一条历史命令|
|`/`|向后搜索历史|
|`?`|向前搜索历史|
|`n`|按当前方向重复搜索|
|`N`|反方向重复搜索|

这里的 `j`、`k`、`/`、`?` 都是 普通模式中的操作。

- Vi 模式下的 `bindkey` 与 Keymap

ZLE 有多个按键映射表（Keymap）。

在 Vi 模式中，最重要的两个是：

|Keymap|对应模式|用途|
|---|---|---|
|`viins`|插入模式|输入文本、补全、插件快捷键|
|`vicmd`|普通模式|移动、删除、修改、历史操作|

执行：

```
bindkey -v
```

会启用 Vi 风格的基础键位配置。

查询：

```
bindkey -M viins '^R'
bindkey -M vicmd '^R'
```

就可以分别检查插入模式和普通模式下的 `Ctrl+R`。

`如何给不同模式分别设置快捷键？`

例如，仅在插入模式中设置 `Ctrl+A` 移动到行首：

```
bindkey -M viins '^A' beginning-of-line
```

仅在普通模式中设置 `H` 移动到行首：

```
bindkey -M vicmd 'H' vi-beginning-of-line
```

这里 `-M` 指定目标 Keymap。

`为什么不建议在 Vi 模式中随便使用 bindkey？`

因为如果不指定 `-M`，很容易误以为自己修改了两个模式的按键。

例如：

```
bindkey '^R' fzf-history-widget
```

一般只会修改当前主键位映射所指向的键位表，而不一定覆盖 `vicmd`。

因此，在 Vi 模式下自定义快捷键，建议明确写出 `-M viins` 或 `-M vicmd`

#### 初始化与插件加载顺序
每次打开 Kitty 并启动交互式 Zsh，Shell 都需要完成一系列初始化操作。
1. 读取zsh启动文件，包括交互式shell 的.zshrc
2. 设置基础行为：历史记录、shell选项
3. 初始化补全系统：compinit、补全函数
4. 选择vi编辑模式：bindkey -v
5. 加载ZLE插件autosuggestions、fzf
6. 初始化工具与提示符zoxide、starship
7. 加载语法高亮syntax-highlighting

#### 故障排查与配置维护
|命令|核心用途|适用场景|
|---|---|---|
|`zsh -n`|检查脚本语法|修改 `.zshrc` 后|
|`zsh -f`|启动精简 Zsh|排除个人配置干扰|
|`zsh -x`|跟踪脚本执行|定位初始化错误|
|`zprof`|分析函数耗时|定位启动瓶颈|
|`time` / `hyperfine`|测量整体耗时|比较优化效果|
|`cp` / `diff`|备份、比较、回滚|安全维护配置|
常见故障与对应排查命令

|故障现象|优先检查|
|---|---|
|`.zshrc` 报解析错误|`zsh -n ~/.zshrc`|
|打开 Kitty 后提示符异常|`zsh -f`、`zsh -ixc exit`|
|Vi 模式没有生效|`bindkey -M vicmd 'h'`|
|`Ctrl+R` 仍然打开 fzf|`bindkey -M vicmd '^R'`|
|Tab 补全异常|`print -r -- "${_comps[git]}"`、`bindkey -M viins '^I'`|
|自动建议没有显示|检查插件加载和历史建议策略|
|语法高亮失效|检查 `source` 路径与加载顺序|
|`z`、`zi` 不存在|`whence -w z zi`|
|启动缓慢|`hyperfine`、`zprof`|



- 语法检查

```
zsh -n ~/.zshrc
```
局限性： `zsh -n` 不执行 `source`、`eval` 等命令，因此不会自动检查它们在运行时加载的全部脚本，也无法发现工具缺失或按键冲突。

- 隔离个人配置

当你怀疑 `.zshrc` 导致某个问题时，可以启动一个精简环境：
```
zsh -f
```
`-f` 表示快速启动，跳过通常的用户启动配置，但不能理解为完全没有任何系统初始化；例如 `.zshenv` 仍可能被读取。

#### zsh vi模式专题
ZLE 如何管理模式、按键映射和编辑操作
自行配置 fzf、自动建议、模式指示器以及 Vim 编辑命令行。

##### Keymap
```
bindkey -v
```

用于启用 Vi 风格编辑。

但 Zsh 并不是简单地维护一个“当前模式”变量，而是通过 Keymap（按键映射表） 决定按键对应什么操作。

|Keymap|作用|典型操作|
|---|---|---|
|`viins`|Vi 插入模式|输入文字、Tab 补全、fzf 搜索|
|`vicmd`|Vi 普通模式|`h`、`l`、`dw`、`ciw`、`u`|
|`main`|当前主键位映射入口|通常指向 `viins`|

这里有一个容易混淆的地方：

`main` 不是第三种 Vi 编辑模式。 它是一个特殊的 Keymap 名称，通常链接到默认的主键位表。

可以执行：

```
bindkey -lL main
```

在启用 Vi 模式的环境中，通常可以看到：

```
bindkey -A viins main
```

表示 `main` 与 `viins` 关联。

查看所有 Keymap

```
bindkey -l
```

再分别查看：

```
bindkey -M viins
bindkey -M vicmd
```

你会发现相同的按键，在两个 Keymap 中可能对应不同 Widget。

#####  什么是 ZLE Widget
ZLE Widget 可以理解为一项可执行的命令行编辑动作。

例如：

```
bindkey -M vicmd 'w'
```

通常返回：

```
"w" vi-forward-word
```

表示在 Vi 普通模式下按 `w`，调用 `vi-forward-word`。

再看：

```
bindkey -M vicmd 'u'
```

通常返回：

```
"u" undo
```

即撤销。
因此，ZLE 的工作关系是：
1. 键盘输入：w
2. 当前Keymap：vicmd查找按键w对应的Widget
3. Widget：vi-forward-word
4. 执行编辑操作

`查看 ZLE Widget`

```
zle -la
```

这会列出已定义的 Widget，输出可能非常多。

可以筛选 Vi 相关 Widget：

```
zle -la | grep '^vi-'
```

或者查询某个 Widget：

```
zle -lL vi-forward-word
```

注意：`zle -lL` 主要用于列出用户定义的 Widget 定义；对于内置 Widget，不一定会打印出你期望的函数源码。要查看某个按键是否使用内置 Widget，`bindkey` 更直接。

##### bindkey 的进阶语法
掌握以下五种形式，就足够管理绝大多数 Zsh Vi 快捷键。

|命令|用途|
|---|---|
|`bindkey -v`|启用 Vi 编辑键位|
|`bindkey -M vicmd 'x'`|查询普通模式中 `x` 的绑定|
|`bindkey -M viins '^R' redo`|将插入模式 Ctrl+R 绑定到指定 Widget|
|`bindkey -M vicmd`|列出普通模式所有绑定|
|`bindkey -L`|以可重新执行的命令形式列出绑定|

例如：

```
bindkey -M vicmd 'x'
bindkey -M vicmd 'dw'
bindkey -M vicmd '^R'
```

这里需要注意：`dw` 是一组 Vi 编辑命令，通常由 `d` 操作符和后续的 `w` 动作组合完成，并不一定存在一个名为 `dw` 的独立按键绑定。

所以：

```
bindkey -M vicmd 'dw'
```

不一定能查询到你想象中的“删除单词”Widget。

正确的理解是：

1. 按 `d`，进入等待移动动作的操作符状态。
    
2. 按 `w`，指定删除范围。
    
3. ZLE 组合执行删除操作。
    

这和 Vim 的操作符加移动命令模型相似。

##### 常用操作符
###### vi编辑的基本模型

|操作符|作用|示例|
|---|---|---|
|`d`|删除|`dw`、`d$`|
|`c`|修改并进入插入模式|`cw`、`c$`|
|`y`|复制到 ZLE 缓冲区|`yw`、`y$`|


|移动命令|作用|
|---|---|
|`w`|移动到下一个单词开头|
|`b`|移动到前一个单词开头|
|`e`|移动到单词末尾|
|`0`|移动到行首|
|`^`|移动到首个非空白字符|
|`$`|移动到行尾|

因此可以组合：

```
dw    删除到下一个单词边界
db    向前删除一个单词范围
d$    删除到行尾
c$    修改到行尾并进入插入模式
y$    复制到行尾
```

Vi 模式还支持重复次数。

例如：

```
3w    向前移动三个单词
2dw   删除两个单词范围
3x    删除三个字符
```

这里 `2dw` 可以理解为：对 `dw` 操作应用两倍的移动范围。

###### dw、cw 与 ciw 的区别
这是从 Vim 迁移到 Zsh 时最值得注意的地方。

在 Vim 中：

|命令|含义|
|---|---|
|`dw`|删除到下一个单词边界|
|`cw`|修改到单词末尾附近并进入插入模式|
|`ciw`|修改整个当前单词|
|`diw`|删除整个当前单词|
|`daw`|删除一个单词及相关空白|

但在 Zsh 原生 ZLE 中，`ciw`、`diw`、`daw` 这类 Vim 文本对象组合不能直接视为默认支持。

ZLE 具有自己的 Vi Widget，例如 `vi-delete`、`vi-change`、`vi-forward-word`，但没有完整实现 Vim 的所有文本对象机制。故不能使用i，a这样的组合

###### 字符查找：`f`、`F`、`t`、`T`
这些命令特别适合编辑较长的 Shell 命令。

假设当前命令是：

```
sudo pacman -Syu firefox
```

|命令|方向|光标落点|
|---|---|---|
|`fx`|向右|字符 `x` 上|
|`Fx`|向左|字符 `x` 上|
|`tx`|向右|字符 `x` 前一个位置|
|`Tx`|向左|字符 `x` 后一个位置|

例如：

```
ff
```

表示向右查找下一个 `f`。

```
tf
```

表示向右查找 `f`，但停在它前面。

`;` 和` ,`：重复字符查找
在 Vim 风格编辑中：

- `;`：按原方向重复最近一次 `f`、`F`、`t`、`T` 查找。
    
- `,`：按相反方向重复查找。

过，ZLE 对这些按键的实现与 Vim 可能存在差异，尤其是 `t`、`T` 的重复行为。因此，建议先检查实际绑定，再以当前 Zsh 版本的交互结果为准。

执行：

```
bindkey -M vicmd 'f'
bindkey -M vicmd 'F'
bindkey -M vicmd 't'
bindkey -M vicmd 'T'
bindkey -M vicmd ';'
bindkey -M vicmd ','
```

如果某个按键显示 `undefined-key`，说明当前 Keymap 中没有为它注册相应操作。

###### 撤销、重做与重复编辑
| 命令       | 功能     | 说明             |
| -------- | ------ | -------------- |
| `u`      | Undo   | 撤销编辑           |
| `Ctrl+R` | Redo   | 重做已撤销的编辑，需绑定正确 |
| `.`      | Repeat | 重复上一次可重复的编辑操作  |
###### 添加autosuggestions相关快捷键
```
# ── 编辑按键 ──────────────────────────────────
bindkey -v
KEYTIMEOUT=10
# 仅调整 Vi 插入模式
bindkey -M viins '^F' autosuggest-accept
bindkey -M viins '^[f' forward-word
```


## niri配置
Mod+T正常启动一个kitty终端，Mod+/右下角启动一个浮动终端其app-id为quickterminal

```zsh
vim ~/.config/niri/config.kdl

#binds内添加
    Mod+T hotkey-overlay-title="Open a Terminal: kitty" { spawn "kitty" "--single-instance"; }
    // 临时使用：浮动终端
    Mod+Slash {
        spawn "kitty" "--single-instance" "--class" "quickterminal" "-o" "background_opacity=0.6";
    }
#添加一个window-rule，放在其他window-rule之后防止效果被覆盖
window-rule {
    match app-id="^quickterminal$"
    open-floating true
    default-column-width { proportion 0.4; }
    default-window-height { proportion 0.5; }
    default-floating-position x=20 y=20 relative-to="bottom-right"
}
#default-floating-position设置浮动窗口位置
#relative-to="bottom-right"以工作区右下角为基准
```

- "--single-instance"：可选，让 Kitty 尽可能复用已有的 Kitty 进程，而不是每次启动终端都创建一个新的独立进程，优点：减少资源占用，提高启动效率，方便统一管理，缺点：进程崩溃会导致所有终端窗口崩溃
- "--class" "quickterminal"：指定 Kitty 窗口的应用类名，在 Niri（Wayland）环境中通常对应窗口的 `app-id`，niri msg pick-window时用到
- "-o" "background_opacity=0.6"：启动 Kitty 时临时覆盖配置文件中的背景透明度，将终端背景设置为 60% 不透明


# 可选配置
## Oh My Zsh框架
通过该框架可以快捷方便的管理zsh的补充功能。如果要配置该框架无须安装前述的starship和zsh独立插件
官网<https://ohmyz.sh/>

awesome收集<https://github.com/unixorn/awesome-zsh-plugins>

1. 安装

```zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

安装后，就已经有一些默认效果，如命令行提示符的主题变化。安装后会覆盖.zshrc

2. 修改主题

oh-my-zsh 提供了许多内置主题，可查看 [themes](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes) 获取一系列的主题
```zsh
vim ~/.zshrc
# 将ZSH_THEME修改为
ZSH_THEME="agnoster" # 默认为 robbyrussell
```

3. 内置插件

```zsh
vim ~/.zshrc
# 修改
plugins=(git z sudo copypath copyfile copybuffer)
```

4. 第三方插件

```zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
# 修改
plugins=(git z zsh-syntax-highlighting zsh-autosuggestions you-should-use)
```

也可以安装主题插件替代内置的主题

```zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# 将ZSH_THEME修改为
ZSH_THEME="powerlevel10k/powerlevel10k"
```
为了确认 NerdFont 字体安装成功，正式开始配置前，要先提出几个问题，识别图片是否如描述说的那样。我们回答后才能进入到主题的自定义，然后自己喜好选择。完成后会生成`$HOME/.p10k.zsh`，想要更细的配置可以自行修改该文件
```zsh
# 重新配置，会重新生成$HOME/.p10k.zsh
p10k configure 
```

我的配置：[.p10k.zsh](../config/zsh/.p10k.zsh)
