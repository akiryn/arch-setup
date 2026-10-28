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
给出参考：[kitty.conf](配置文件/kitty.conf)
详细配置说明见：
3. 美化
这里以已经加入预设的Catppuccin-Mocha为例，通过kitten themes工具配置，选择后立即生效
美化配置原理：
```zsh
#将颜色相关配置写入一个文件
#kitty.conf中通过include引入

# BEGIN_KITTY_THEME
# Catppuccin-Mocha
include current-theme.conf
# END_KITTY_THEME
```
这里给出[current-theme.conf](current-theme.conf)参考，可以直接将其复制到~/.config/kitty/下然后在kitty.conf引入
关于kitten themes使用见<https://sw.kovidgoyal.net/kitty/kittens_intro/?utm_source=chatgpt.com>或

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
### fish
<https://fishshell.com/>

1. 安装Fish
```
sudo pacman -S fish
```
2. 

### zsh
<https://zsh.sourceforge.io/>
1. 安装zsh，插件
```bash
sudo pacman -S zsh
chsh -s /usr/bin/zsh
sudo pacman -S zsh-syntax-highlighting zsh-autosuggestions zsh-completions
```
- zsh-syntax-highlightin高亮，
- zsh-autosuggestions根据历史记录显示灰色建议
- zsh-completions按Tab时显示这里有哪些合法选项
2. 配置
参考[.zshrc](配置文件/zshrc)


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
[starship](配置文件/starship.toml)
也可以用官方提供的一些预设：<https://starship.rs/presets/>
4. 重启终端



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
## Oh My Zsh
