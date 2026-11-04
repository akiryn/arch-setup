AUR 是 Arch 最强大的软件仓库。这个仓库里通常只存放软件的`PKGBUILD`，可以将其理解为一个说明文档也可以将其看出一个脚本（这份“说明文档使用bash脚本语言写成”）。然后`makepkg -si`解析加工该文档会生成一个.pkg.tar.zst包，这篇文档（脚本）告诉 `makepkg` 去哪里取源码、需要哪些依赖、如何构建，以及哪些文件要放进最终的软件包。，再用`pacman -U`安装这个包

通常安装需要执行以下三步
下载对应包PKGBUILD执行makepkg -si，执行pacman -U

yay，paru是两个管理工具，可以更方便的从aur下载包并自动化实现这几步，二者选一个即可，前者go实现，后者rust实现




## PKGBUILD
PKGBUILD是一份给makepkg的说明文档，用以制作一个.pkg.tar.zst包



| 字段或函数         | 在这个包里的作用                                    |
| ------------- | ------------------------------------------- |
| `depends`     | 声明运行依赖，例如 `niri-shorin-fork-git` 和 `waybar` |
| `makedepends` | 声明构建依赖，这里是 `git`                            |
| `source`      | 指向 GitHub 上真正的 Shorin Niri 项目源码             |
| `pkgver()`    | 根据 Git 提交数和短哈希生成版本号                         |
| `package()`   | 把配置模板、壁纸、`shorinniri` 命令和说明文档放入打包目录         |

`source`指定从哪里取得制作这个.pkg.tar.zst包所需的文件？

`depends`	安装这个.pkg.tar.zst包时，系统还需要有哪些包？

`makedepends`做这个.pkg.tar.zst包需要的工具

`pkgname`设置包名`pkgdesc`设置包的简短描述，查询软件包信息时可以看到。`pkgrel=1` 是打包修订号。同一源码版本如果调整了打包方式，可以增加这个数字。`url` 是项目主页，用于展示。实际取源码的地址在第 48 行。



https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=shorin-niri-git

|行|逐行解读|
|---|---|
|10|注释说明下面是核心依赖，包含桌面组件和脚本所需工具。|
|11|`depends=(` 开始定义 Bash 数组。数组里的包是安装 `shorin-niri-git` 时必须满足的依赖。|
|12|`bash` 提供脚本解释器，`curl` 提供命令行网络请求工具。|
|13|声明 Niri 分支、`nirius`、Mako 通知、Polkit 认证代理、XWayland 支持和空闲管理工具。|
|14|声明 Fuzzel 启动器、通知工具、亮度调节、音频可视化和剪贴板工具。|
|15|声明截图和区域选择、锁屏、屏显提示、壁纸、Waybar、配色生成和剪贴板历史界面等组件。|
|16|`)` 结束 `depends` 数组。这些包名会成为依赖记录，各组件的文件由各自的软件包提供。|
|18|注释说明项目还会通过 `shorinniri` 脚本同步配套软件。该脚本有自己的软件清单。|
|19|`optdepends=(` 开始定义可选依赖。每项通常写成 `'包名: 用途说明'`。仅出现在这里的包不会因此被 `yay -S shorin-niri-git` 自动安装。|
|20|光标主题和 MPV 播放器。|
|21|基础字体、中日韩字体和 Emoji 字体。|
|22|Nerd Font、定制字体和中文字体。|
|23|Nautilus、Thunar 文件管理器和 File Roller 归档工具。|
|24|EXE 缩略图提取和 Python 图像处理工具。|
|25|SMB 网络共享、MTP 设备和相机访问支持。|
|26|Nautilus 的终端扩展和 GNOME 密钥环。|
|27|文件缩略图服务，以及 PDF 和视频缩略图支持。|
|28|WebP、文件缩略图相关库，以及 GTK、GNOME 桌面门户。|
|29|GStreamer 多媒体插件。|
|30|Thunar 的归档和可移动设备管理插件。|
|31|`bat`、Flatpak 应用商店、蓝牙终端界面和剪贴板通知工具。|
|32|`eza`、Fish、Starship 和 Zoxide，分别用于列目录、交互式 Shell、提示符和目录跳转。|
|33|截图编辑器和两个录屏工具。|
|34|终端图像预览、图像查看和处理工具。|
|35|图像放大、JSON 处理、GTK 外观设置和 pacman 辅助工具。|
|36|色温调节、音量控制和包降级工具。|
|37|系统调用跟踪、终端选择工具、Kitty 和 Firefox。|
|38|系统信息、资源监控和磁盘用量工具。|
|39|Shorin 配套工具、Linux QQ 的 Wayland 修复和显示器控制服务。|
|40|Firefox 主题联动工具和 Waypaper 壁纸选择器。|
|41|长截图、录屏菜单和 Proton 启动包装器。|
|42|Fcitx5 输入法框架、语言模型、配置工具和 GTK、Qt 集成。|
|43|Rime 输入法引擎、词库、五笔方案和大模型翻译相关工具。|
|44|`)` 结束 `optdepends` 数组。|
|45|`makedepends=('git')` 声明构建时需要 Git。后面既要用它取源码，也要用它读取提交信息。|


`$srcdir` 由 `makepkg` 设置。
`$srcdir` 里是取回来的项目文件，`$pkgdir` 里是即将装进归档的文件。 比如，`$pkgdir/usr/bin/shorinniri` 是构建期间的暂存路径。之后 pacman 安装归档时，对应文件才落到系统的 /usr/bin/shorinniri。


假设 `yay` 把 AUR 的打包文件放在下面这个目录，并且没有自定义 `makepkg` 的构建路径：

```
~/.cache/yay/shorin-niri-git/
└── PKGBUILD
```

**第一步，`makepkg` 确定构建路径。** 在准备源码之前，它把变量 `srcdir` 设为这个构建目录下的 `src` 路径。在这个例子里，`$srcdir` 展开后就是 `$HOME/.cache/yay/shorin-niri-git/src` 对应的绝对路径。此时只是**确定了源码工作目录在哪里**。

**第二步，`makepkg` 按 `source` 准备源码。** 这个脚本的 `source` 指向 GitHub 上的 `shorin-niri.git`。`makepkg` 获取或复用 Git 仓库，再把用于这次构建的工作副本检出到 `src/shorin-niri/`。这时目录关系是：

```
~/.cache/yay/shorin-niri-git/       ← yay 放打包文件的目录
├── PKGBUILD
└── src/                          ← $srcdir
    └── shorin-niri/              ← $srcdir/shorin-niri
        ├── dotfiles/
        ├── Wallpapers/
        └── shorinniri
```

**第三步，`makepkg` 调用 `pkgver()`。** 执行到 `cd "$srcdir/shorin-niri"` 时，Bash 把 $srcdir 替换成前面已经设置好的路径，然后 `cd` 进入已经检出的 Git 工作副本。下一行才在这个副本里用 `git` 读取提交数和短哈希。 


**写这份 `PKGBUILD` 时，你负责填写字段、定义约定好的函数，`makepkg` 负责在正确的阶段读取字段和调用函数。** 因此文件末尾无需写 `pkgver` 或 `package` 来手动调用它们。

以 `shorin-niri-git` 为例：

1. **加载 `PKGBUILD`。** Bash 执行顶层赋值，把 `depends`、`source` 等数组设好，同时定义 `pkgver()` 和 `package()`。这时两个函数的函数体还没运行。
2. **准备源码。** `makepkg` 读取 `source` 数组，按里面的 Git 地址取得源码，并把工作副本准备到 `$srcdir/shorin-niri`。
3. **计算版本。** `makepkg` 发现定义了 `pkgver()`，就在源码就绪后调用它，把函数输出的版本字符串用作这次构建的 `pkgver`。
4. **组装并归档。** `makepkg` 设置好 $pkgdir 后调用 `package()`。函数把脚本、配置模板和壁纸复制进去，随后 `makepkg` 将暂存内容和包元数据打成安装包。

有一个区别值得记住。**`package()` 是 `makepkg` 认识的约定函数名。** 如果你自己另外定义了 `copy_wallpapers()`，`makepkg` 不会自动调用它。你需要在 `package()` 里显式调用它。也就是makepkg负责统筹的只有PKGBUILD中他认识的预先设定的函数