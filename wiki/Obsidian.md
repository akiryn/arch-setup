

# obsidian
[obsidian官网](https://obsidian.md/)
[obsidian官网文档](https://obsidian.md/help/)

|               | 位置                                             |
| ------------- | ---------------------------------------------- |
| 应用程序          | `~/Applications/Obsidian.AppImage`             |
| 菜单启动器快捷方式     | `~/.local/share/applications/obsidian.desktop` |
| 笔记库（示例，可自行选择） | `~/Documents/Obsidian`/                        |
 
`AppImage`方式安装,本节指令使用bash执行,其他shell可能不适配
```bash
#缺少依赖补上:
sudo dnf install fuse fuse-libs -y

url=$(curl -fsSL https://obsidian.md/download |
  grep -oE 'https://github\.com/obsidianmd/obsidian-releases/releases/download/[^/]+/Obsidian-[0-9.]+\.AppImage' |
  head -n 1)

printf '%s\n' "$url"

mkdir -p ~/Applications
curl -fL --retry 3 "$url" -o ~/Applications/Obsidian.AppImage.download &&
chmod +x ~/Applications/Obsidian.AppImage.download &&
mv -f ~/Applications/Obsidian.AppImage.download ~/Applications/Obsidian.AppImage

#启动
~/Applications/Obsidian.AppImage

```
## 添加到系统的应用菜单/fuzzel程序启动器
```bash
mkdir -p ~/.local/share/applications
cat > ~/.local/share/applications/obsidian.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Obsidian
Comment=Markdown Knowledge base
Exec=sh -c 'exec "$HOME/Applications/Obsidian.AppImage" "$@"' sh %U
Icon=obsidian
Terminal=false
Categories=Office;
EOF
```
> [!info]- 快捷方式字段说明
>
> | 字段 | 作用 |
> | --- | --- |
> | `[Desktop Entry]` | 主配置段的固定名称，告诉读取者下面是应用入口信息 |
> | `Type=Application` | 表示这是可以运行的应用 |
> | `Name=Obsidian` | 菜单中显示的名称 |
> | `Comment=…` | 应用说明，可能用于提示文字或搜索，不是代码注释 |
> | `Exec=…` | 启动命令；这里执行指定的 AppImage |
> | `%U` | 多个 URL 的参数占位符；没有传入 URL 时会移除 |
> | `Icon=…` | 图标的绝对路径，也可以是图标主题中的名称 |
> | `Terminal=false` | 不要求在终端窗口中运行 |
> | `Categories=Office;` | 将应用归入办公类；分类列表使用分号分隔 |

## 解决obsidian图标未显示问题
```bash
mkdir -p ~/.local/share/icons
curl -fL https://obsidian.md/favicon.svg -o ~/.local/share/icons/obsidian.svg

sed -i "s|^Icon=.*|Icon=$HOME/.local/share/icons/obsidian.svg|" ~/.local/share/applications/obsidian.desktop
#这条命令会直接修改 Obsidian 快捷方式文件，把图标设置为你下载的 SVG 图片,将图片下载到~/.local/share/icons/。
#修改前Icon=obsidian，修改后Icon=/home/y/.local/share/icons/obsidian.svg
#fuzzel没有显示图标但dms应用管理器已经显示了图标,同时本机图标路径正确，疑似与该 SVG 的 CSS 样式和 Fuzzel的NanoSVG 渲染兼容性有关。可尝试将 CSS 类名对应的颜色直接写入图形属性。
sed -i 's/class="purple"/fill="#9974F8"/g' ~/.local/share/icons/obsidian.svg
#9974F8取自官网图标,官网以后更改图标结构，命令就不合适了
```

> [!tip]- 补充信息
> Fuzzel 和 DMS 分别读取什么？
> 两者都使用 XDG 标准的应用入口，默认来源相同,就fuzzel,dms菜单这种情况而言读取是相同的,但隐藏规则、排序、搜索和刷新方式可能不同，最终显示的列表不一定完全一样
> `~/.local/share/applications/`当前用户的应用入口,如`obsidian.desktop`
> `/usr/local/share/applications/`本机额外安装的应用入口
> `/usr/share/applications/`系统软件包安装的应用入口`Alacritty.desktop`,`org.mozilla.firefox.desktop`等
> - **Fuzzel**：收集这些目录中的 `.desktop` 文件，生成可搜索的应用列表。[Fuzzel 手册](https://man.archlinux.org/man/fuzzel.1.en)
> - **DMS 菜单**：通过 Quickshell 的 `DesktopEntries` 获取应用列表
> Fuzzel 通常是每次调用时启动，选完应用就退出，不是一直运行的后台服务。修改后及时刷新
> 如果卡死了执行`pkill -x fuzzel`,`fuzzel` 
> DMS 会响应应用列表变化，但图标内容或缓存未必立即刷新；先重新打开菜单，仍未更新可执行 dms restart。注销重登录作为最后的处理方式。

## 快捷键


## 页面美化
