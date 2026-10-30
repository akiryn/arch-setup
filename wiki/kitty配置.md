参考文档 [Kitty 官方配置文档](https://sw.kovidgoyal.net/kitty/conf/?utm_source=chatgpt.com)   [Arch Linux kitty.conf 手册](https://man.archlinux.org/man/kitty.conf.5.en?utm_source=chatgpt.com) [Kitten 工具介绍](https://sw.kovidgoyal.net/kitty/kittens_intro/?utm_source=chatgpt.com) [快捷键帮助文档](https://sw.kovidgoyal.net/kitty/actions/?utm_source=chatgpt.com) [可映射动作参考手册](https://sw.kovidgoyal.net/kitty/actions/?utm_source=chatgpt.com)





## Kitty 配置文件基础
- Kitty 的常规配置采用：

```
配置项 配置值
```

- Kitty 支持通过 `include` 引入其他配置文件。还支持通过`globinclude`使用通配符匹配并引入多个配置文件。这意味着可以按功能拆分配置，而不必将所有选项放在一个巨大的文件中

```
include theme.conf
include fonts.conf
globinclude themes/*.conf
```

- Ctrl+Shift+F2	编辑配置文件
- Ctrl+Shift+F5	重新加载配置
- Ctrl+Shift+F6	查看配置调试信息

## Kitty 字体配置

### 1. 字体选择
- `font_family`：设置主字体家族。
- `bold_font`：设置粗体字体。
- `italic_font`：设置斜体字体。
- `bold_italic_font`：设置粗斜体字体。
- `auto`：让 Kitty 自动选择相应字形。

```
font_family JetBrainsMono Nerd Font
bold_font auto
italic_font auto
bold_italic_font auto
```

### 2. 字号与字体度量
- `font_size`：设置字号，单位 pt。
- `modify_font cell_height`：修改字符单元格高度。
- `modify_font cell_width`：修改字符单元格宽度。
- `modify_font baseline`：修改文字基线。
- 字体度量和窗口内边距是不同概念。

```
modify_font cell_height 110%
modify_font cell_width 105%
modify_font baseline 2
```

### 3. Nerd Font 与特殊字符
- `Nerd Font`：添加大量开发工具图标字形的字体。
- `symbol_map`：可以指定某个 Unicode 字符或字符范围使用特定字体。
- `narrow_symbols`：调整特定符号的单元格宽度处理。

```
symbol_map U+E0A0-U+E0A3 Symbols Nerd Font Mono
```
### 4. 字体连字

- `disable_ligatures never`：不禁用连字。
- `disable_ligatures always`：禁用连字。
- `disable_ligatures cursor`：光标位置附近禁用连字。
- `font_features`：控制字体的 OpenType 特性。
- 连字只影响视觉呈现，不改变实际文本。
```
font_features JetBrainsMonoNerdFont-Regular +liga
```
- +liga 表示启用标准连字特性，-liga 表示禁用
### 5. 常用命令
```zsh
#这条命令用于查看 Kitty 能够识别的字体及其字形信息
kitty +list-fonts
#fc-match 是 Fontconfig 的工具，可以查看该字体名称最终匹配到哪个字体文件
fc-match "JetBrainsMono Nerd Font"
```
`kitty +list-fonts` 是 Kitty 的交互式字体选择器；`fc-match` 是 Fontconfig 的字体匹配查询工具。二者作用不同。


## Kitty 颜色、主题与透明度配置

### 1. 基础颜色
- `foreground`：默认前景色。
- `background`：终端背景色。
- `selection_foreground`：选中文字颜色。
- `selection_background`：选区背景颜色。
- `color0`～`color15`：ANSI 基础调色板。
### 2. 光标配置
- `cursor`：光标颜色。
- `cursor_text_color`：光标覆盖文字的颜色。
- `cursor_shape`：光标形状，可选 block、beam、underline。
- `cursor_blink_interval`：光标闪烁间隔。
### 3. 背景透明度
- `background_opacity`：背景不透明度，通常范围为 0～1。
- `dynamic_background_opacity`：允许动态调整背景不透明度。
- 透明度由 Kitty 与 Wayland 合成器共同实现。
- `background` 与 `background_opacity` 相互独立。
### 4. 窗口及标签栏颜色
- `active_border_color`：Kitty 内部活动窗口边框。
- `inactive_border_color`：非活动窗口边框。
- `active_tab_background`：活动标签背景。
- `inactive_tab_background`：非活动标签背景。
- `tab_bar_background`：标签栏背景。
### 5. 主题管理
- `kitten themes`：交互式主题管理工具。
- `current-theme.conf`：当前主题配置文件。
- `include current-theme.conf`：引入当前主题。
- 主题文件只覆盖实际定义的配置项。
- 切换主题可能重写 current-theme.conf，因此个人设置建议放在主配置中。

## Kitty 窗口、标签页与滚动配置
### 1. 窗口层级
Kitty 分为三个层级：
- OS Window：操作系统顶层窗口，由 Niri 管理。
- Tab：Kitty 内部标签页。
- Window：标签页内的终端窗格。
### 2. 窗口布局
- `enabled_layouts`：限制允许使用的布局及切换顺序。
- `tall`：主窗格与侧边窗格组合。
- `horizontal`：多个窗格上下排列。
- `vertical`：多个窗格左右排列。
- `grid`：网格布局。
- `stack`：堆叠布局。
```
enabled_layouts tall,horizontal
```
### 3. 窗口尺寸与边距
- `window_padding_width`：窗格内容与边缘之间的内边距。
- `window_margin_width`：窗格外侧间距。
- `remember_window_size`：记住窗口尺寸。
- `initial_window_width`：初始窗口宽度。
- `initial_window_height`：初始窗口高度。
- `hide_window_decorations`：请求隐藏窗口装饰。
### 4. 标签栏
- `tab_bar_min_tabs`：显示标签栏的最小标签数。
- `tab_bar_style`：标签栏样式。
- `tab_powerline_style`：Powerline 标签分隔形状。
- `active_tab_font_style`：活动标签字体样式。
- `inactive_tab_font_style`：非活动标签字体样式。
```
tab_bar_min_tabs 2
tab_bar_style powerline
tab_powerline_style slanted
active_tab_font_style bold-italic
inactive_tab_font_style normal
enabled_layouts tall,horizontal
```
### 5. 滚动历史
- `scrollback_lines`：历史输出保留行数。
- `wheel_scroll_multiplier`：鼠标滚轮速度倍率。
- `scrollback_pager`：外部历史查看程序。

## Kitty 快捷键配置

### 1. 基本语法
```ini
map 按键组合 动作 [参数]
```
- `map`：定义快捷键映射。
- `ctrl`、`shift`、`alt`、`super`：修饰键。
- `kitty_mod`：统一的 Kitty 修饰键组合默认值为`ctrl+shift`。
- `new_window`、`new_tab` 等：Kitty 动作。
### 2. kitty_mod
```ini
kitty_mod ctrl+shift
map kitty_mod+enter new_window
```
通过 `kitty_mod` 可以集中管理多个快捷键的修饰键。
### 3. 常用动作

| 动作 | 作用 |
|---|---|
| `new_window` | 新建内部窗格 |
| `new_os_window` | 新建顶层窗口 |
| `new_tab` | 新建标签页 |
| `close_window` | 关闭当前窗格 |
| `next_tab` | 下一个标签页 |
| `next_layout` | 下一个布局 |
| `copy_to_clipboard` | 复制 |
| `paste_from_clipboard` | 粘贴 |
| `load_config_file` | 重载配置 |

### 4. 快捷键覆盖
- 同一按键组合可以通过新的 `map` 重新绑定。
- `no_op`：不执行 Kitty 动作。
- `clear_all_shortcuts yes`：清除此前的快捷键映射。
### 5. 多级快捷键
```ini
map ctrl+shift+x>t new_tab
```
`>` 表示先后按键，而不是同时按下。

### 6. 与 Niri 的关系
Niri 负责全局快捷键和顶层窗口管理。Kitty 负责应用内部快捷键。被 Niri 拦截的按键组合通常不会继续传递给 Kitty。建议 Niri 使用 Super，Kitty 使用 Ctrl+Shift，以减少冲突。

## Kitten、Shell 集成与高级配置

### 1. Kitten
Kitten 是 Kitty 提供的一组辅助工具，可以完成主题切换、图片显示、SSH 集成、交互式选择等操作。基本语法：`kitten <工具名称> [参数]`

| 命令                     | 功能               |
| ---------------------- | ---------------- |
| `kitten themes`        | 交互式选择终端主题        |
| `kitten icat`          | 在终端中显示图片         |
| `kitten hints`         | 识别并选择 URL、路径等文本  |
| `kitten ssh`           | 增强 SSH 远程终端体验    |
| `kitten diff`          | 交互式比较文件差异        |
| `kitten @`             | 使用 Kitty 远程控制命令  |
| `kitten choose-fonts`  | 交互式配置字体          
#### kitten hints快速选择文本

| 参数                  | 作用        |
| ------------------- | --------- |
| `--type url`        | 匹配 URL    |
| `--type path`       | 匹配文件路径    |
| `--type word`       | 匹配单词      |
| `--type line`       | 匹配整行      |
| `--type hash`       | 匹配 Git 哈希 |
| `--type linenum`    | 匹配文件名与行号  |
| `--type regex`      | 使用正则表达式匹配 |
| `--program @`       | 复制到系统剪贴板  |
| `--program -`       | 将内容插入终端   |
| `--program default` | 使用默认程序处理  |


其中 `--program` 决定选中内容之后做什么，而 `--type` 决定识别什么。

该功能通常配合自定义快捷键使用，添加`keybindings.conf`自定义快捷键。操作方式：先按 `Ctrl+Shift+P`，**全部松开，再按小写字母**。

|第二键|功能|处理方式|典型场景|
|---|---|---|---|
|`u`|URL 网址|复制到剪贴板|分享文档链接|
|`f`|File 文件路径|插入当前命令行|输入 `nvim` 后选择路径|
|`h`|Hash 提交哈希|插入当前命令行|输入 `git show` 后选择哈希|
|`l`|Line 整行文字|复制到剪贴板|复制错误信息、日志|
|`n`|Number 文件行号|新标签用 Neovim 打开|从 `main.c:42` 跳到代码|

具体配置：

```
# 复制网址
map ctrl+shift+p>u kitten hints --type url --program @

# 插入路径
map ctrl+shift+p>f kitten hints --type path --program -

# 插入哈希
map ctrl+shift+p>h kitten hints --type hash --program -

# 复制整行
map ctrl+shift+p>l kitten hints --type line --program @

# 打开文件并跳到指定行
map ctrl+shift+p>n kitten hints --type linenum --linenum-action tab nvim +{line} {path}
```

#### kitten ssh
kitten ssh 并不是重新实现了一套 SSH 协议，而是在系统 SSH 的基础上，自动准备更适合 Kitty 的远程终端环境。


#### kitten @


### 2. Shell Integration
```
shell_integration enabled
```
- 让 Kitty 识别 Shell 提示符和命令边界。
- 支持提示符跳转、命令输出查看等功能。
- 与 `shell zsh` 不同。
- 不等于 Oh My Zsh。

官方说明：[Shell integration](https://sw.kovidgoyal.net/kitty/shell-integration/?utm_source=chatgpt.com)。


### 3. 启动会话
假设你希望打开 Kitty 后，自动建立开发工作区：

- 第一个标签页用于编辑代码。
    
- 第二个标签页用于编译。
    
- 第三个标签页用于 Git 操作。
    

Kitty 可以通过 Session 文件描述启动布局。

例如，在 `kitty.conf` 中设置：

```
startup_session ~/.config/kitty/dev.session
```
用于指定启动时加载的 Kitty Session 文件，可以预设标签页、窗格和程序。


再建立 `dev.session`：

```
new_tab Editor
launch --type=window --cwd=current nvim

new_tab Build
launch --type=window --cwd=current zsh

new_tab Git
launch --type=window --cwd=current zsh
```

### 4. 远程控制
```
kitten @ ls
```
- `kitten @`：远程控制命令入口。
- `allow_remote_control`：控制远程访问权限。
- 不建议无条件开放远程控制。

### 5. 重要区别
- Kitten ≠ Kitty 本体。
- Shell Integration ≠ Shell 插件框架。
- `env` ≠ Shell 局部变量。
- Session ≠ Niri 工作区。
- Remote Control ≠ 普通快捷键映射。

# Kitty 配置管理总结

## 1. 配置文件

默认路径：

```
~/.config/kitty/kitty.conf
```

使用 `include` 加载其他配置文件：

```
include fonts.conf
include appearance.conf
include keybindings.conf
```

## 2. 推荐配置结构

```
~/.config/kitty/
├── kitty.conf
├── fonts.conf
├── appearance.conf
├── tabs.conf
├── keybindings.conf
└── current-theme.conf
```

## 3. 常用配置项

|配置项|作用|
|---|---|
|`shell`|指定 Shell|
|`shell_integration`|Shell 集成|
|`font_family`|字体家族|
|`font_size`|字体大小|
|`background_opacity`|背景不透明度|
|`window_padding_width`|窗格内边距|
|`enabled_layouts`|可用布局|
|`tab_bar_style`|标签栏样式|
|`scrollback_lines`|滚动历史行数|
|`kitty_mod`|快捷键修饰组合|
|`map`|自定义快捷键|
|`startup_session`|启动会话|
|`allow_remote_control`|远程控制权限|

## 4. 常用操作

|操作|方法|
|---|---|
|编辑配置|`Ctrl+Shift+F2`|
|重载配置|`Ctrl+Shift+F5`|
|查看配置调试信息|`Ctrl+Shift+F6`|
|查看版本|`kitty --version`|
|查看命令帮助|`kitty --help`|

## 5. 配置维护原则

1. 保留默认快捷键，仅覆盖需要修改的部分。
    
2. 使用 `include` 对配置进行模块化管理。
    
3. 将个人颜色覆盖项放在主题加载之后。
    
4. 通过 `kitten themes` 管理主题文件。
    
5. 修改重要配置前先备份。
    
6. 不随意开放远程控制权限。
    
7. 遇到问题先查看本机版本、帮助和调试信息。
    

# Kitty 默认快捷键汇总

## 1. 基础说明

Kitty 默认使用 `Ctrl+Shift` 作为快捷键修饰组合：

```
kitty_mod ctrl+shift
```

因此，`kitty_mod+enter` 等价于 `Ctrl+Shift+Enter`。

Kitty 的窗口分为三个层级：

- **OS Window**：操作系统顶层窗口，由 Niri 等窗口管理器管理。
    
- **Tab**：Kitty 内部标签页。
    
- **Window**：Kitty 标签页内部的终端窗格。
    

## 2. 剪贴板与字体

|默认快捷键|功能|
|---|---|
|`Ctrl+Shift+C`|复制选中文本|
|`Ctrl+Shift+V`|粘贴剪贴板内容|
|`Ctrl+Shift+S`|粘贴选区内容|
|`Ctrl+Shift+=`|增大字体|
|`Ctrl+Shift+-`|缩小字体|
|`Ctrl+Shift+Backspace`|恢复默认字体大小|

## 3. 窗口管理

| 默认快捷键              | 功能             |
| ------------------ | -------------- |
| `Ctrl+Shift+Enter` | 新建 Kitty 内部窗格  |
| `Ctrl+Shift+N`     | 新建顶层 OS Window |
| `Ctrl+Shift+W`     | 关闭当前内部窗格       |
| `Ctrl+Shift+]`     | 切换到下一个内部窗格     |
| `Ctrl+Shift+[`     | 切换到上一个内部窗格     |
| `Ctrl+Shift+F`     | 向前移动当前窗格       |
| `Ctrl+Shift+B`     | 向后移动当前窗格       |
| `Ctrl+Shift+R`     | 调整内部窗格大小       |
| `Ctrl+Shift+F7`    | 可视化选择窗格        |
| `Ctrl+Shift+F8`    | 可视化交换窗格        |

## 4. 标签页管理

| 默认快捷键              | 功能        |
| ------------------ | --------- |
| `Ctrl+Shift+T`     | 新建标签页     |
| `Ctrl+Shift+Q`     | 关闭当前标签页   |
| `Ctrl+Shift+Right` | 切换到下一个标签页 |
| `Ctrl+Shift+Left`  | 切换到上一个标签页 |
| `Ctrl+Shift+.`     | 向后移动标签页   |
| `Ctrl+Shift+,`     | 向前移动标签页   |
| `Ctrl+Shift+Alt+T` | 设置标签页标题   |

## 5. 布局管理

|默认快捷键|功能|
|---|---|
|`Ctrl+Shift+L`|切换到下一个窗口布局|

布局由 `enabled_layouts` 配置项决定，例如：

```
enabled_layouts tall,horizontal
```

表示仅启用 `tall` 和 `horizontal` 两种布局。

## 6. 滚动历史

|默认快捷键|功能|
|---|---|
|`Ctrl+Shift+Up`|向上滚动一行|
|`Ctrl+Shift+Down`|向下滚动一行|
|`Ctrl+Shift+PageUp`|向上滚动一页|
|`Ctrl+Shift+PageDown`|向下滚动一页|
|`Ctrl+Shift+Home`|滚动到历史顶部|
|`Ctrl+Shift+End`|滚动到历史底部|
|`Ctrl+Shift+H`|使用分页器查看滚动历史|
|`Ctrl+Shift+/`|搜索滚动历史|

## 7. Shell 集成

|默认快捷键|功能|
|---|---|
|`Ctrl+Shift+Z`|跳转到上一条 Shell 提示符|
|`Ctrl+Shift+X`|跳转到下一条 Shell 提示符|
|`Ctrl+Shift+G`|查看上一条命令的输出|

部分功能需要启用 Kitty Shell Integration。

## 8. 配置与高级功能

| 默认快捷键               | 功能            |
| ------------------- | ------------- |
| `Ctrl+Shift+F1`     | 查看快捷键帮助       |
| `Ctrl+Shift+F2`     | 编辑 Kitty 配置   |
| `Ctrl+Shift+F3`     | 打开命令面板        |
| `Ctrl+Shift+F5`     | 重新加载配置        |
| `Ctrl+Shift+F6`     | 显示配置调试信息      |
| `Ctrl+Shift+Escape` | 打开 Kitty 调试终端 |
| `Ctrl+Shift+U`      | 输入 Unicode 字符 |
| `Ctrl+Shift+E`      | 打开 URL 提示选择   |
| `Ctrl+Shift+F11`    | 切换全屏          |
| `Ctrl+Shift+F10`    | 切换最大化         |

## 9. 自定义快捷键

基本语法：

```
map 按键组合 动作 [参数]
```

例如：

```
kitty_mod ctrl+shift

map kitty_mod+enter new_window
map kitty_mod+t new_tab
map kitty_mod+l next_layout
```

其他配置：

```
# 禁用某个快捷键
map ctrl+shift+t no_op

# 清除此前的快捷键映射
clear_all_shortcuts yes

# 多级快捷键：先按 Ctrl+Shift+X，再按 T
map ctrl+shift+x>t new_tab
```

## 10. 使用建议

在 Niri + Kitty 环境中，建议：

- Niri 使用 `Super` 管理工作区和顶层窗口。
    
- Kitty 使用 `Ctrl+Shift` 管理内部窗格、标签页和终端操作。
    
- 优先保留 Kitty 默认快捷键，仅修改存在冲突或不符合习惯的映射。
    
- 自定义快捷键可以集中放在 `keybindings.conf`，再通过 `include keybindings.conf` 引入。
    

**注意：** 本文整理的是常见默认映射，具体行为可能因 Kitty 版本、个人配置及 Niri 快捷键拦截而有所不同。
