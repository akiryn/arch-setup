


目前使用的是 clipse + clipse-gui；仓库采用的是 cliphist + cliphist-tui。

| 名称               | 作用                          | 是否提供界面 |
| ---------------- | --------------------------- | ------ |
| **`wl-copy`**    | 将文字、图片等数据写入 Wayland 剪贴板     | 命令行    |
| **`wl-paste`**   | 读取剪贴板内容，也可以监听内容变化           | 命令行    |
| **clipse**       | 保存和管理剪贴板历史，并提供选择历史的终端界面     | TUI    |
| **clipse-gui**   | 为 clipse 提供图形化历史浏览和选择界面     | GUI    |
| **cliphist**     | 另一套剪贴板历史工具，负责存储、列出和解码历史内容   | 命令行    |
| **cliphist-tui** | 为 cliphist 提供在终端中浏览、选择历史的界面 | TUI    |
| **grim**         | 在 Wayland 下截取屏幕，输出图片        | 命令行    |
| **slurp**        | 让你用鼠标框选区域，输出区域坐标和尺寸         | 框选交互   |
| **Gradia**       | 对截图或图片进行标注、编辑和美化            | GUI    |



`grim`:真正负责“抓取屏幕像素” `slurp`:让你用鼠标“框选区域” `Swappy`:编辑标注工具,更轻量，但功能和交互明显更基础。 `Satty:`编辑标注工具 `wl-clipboard` 是让命令行程序读写 Wayland 剪贴板的工具包。 它包含两个命令：wl-copy把数据放进剪贴板,wl-paste把剪贴板中的数据取出来 `cliphist`:剪贴板管理工具 `mark-shot`:一个功能综合齐全的截图工具,基本可以实现所有截图相关需求



# 截图相关
## 功能需求
- 区域截图,显示器截图,窗口截图,长截图
- 默认只复制到剪贴板
- 贴图,贴图后编辑,贴图后翻译其内容
- OCR

## 相关工具

 `grim`:真正负责“抓取屏幕像素”
 `slurp`:让你用鼠标“框选区域”
 `Swappy`:编辑标注工具,更轻量，但功能和交互明显更基础。
 `Satty:`编辑标注工具
 `wl-clipboard` 是让命令行程序读写 Wayland 剪贴板的工具包。 它包含两个命令：wl-copy把数据放进剪贴板,wl-paste把剪贴板中的数据取出来
 `cliphist`:剪贴板管理工具
 `mark-shot`:一个功能综合齐全的截图工具,基本可以实现所有截图相关需求


## 截图方式比较

niri+dms默认存在三种截图方式(选择niri原生截图)

|对比项|niri 原生截图|DMS 调用 niri 并编辑|DMS 自带截图命令|
|---|---|---|---|
|典型命令|`niri msg action screenshot`|`dms ipc call niri screenshot`|`dms screenshot`|
|谁负责截图|niri|仍然是 niri|DMS 截图工具，具体捕获方式依环境而定|
|是否自动打开编辑器|否|正常保存截图后打开 Swappy 等编辑器|默认不打开编辑器|
|默认保存行为|由 `screenshot-path` 控制|DMS 显式指定文件路径|默认保存文件并复制到剪贴板|
|`screenshot-path null` 是否管用|管用|不能阻止 DMS 指定路径保存|不控制该命令的输出策略|
|只复制、不保存|设置 `null`，或截图界面按 `Ctrl + C`|按 `Ctrl + C`，但不会自动打开编辑器|使用 `--no-file`|
|适合什么需求|简单截图、只复制|截图后立即标注，接受保留原图|用命令控制截图类型、格式和输出|


 

## 基础截图配置
`如果希望所有 niri 截图默认都不保存`
~/.config/niri/config.kdl搜索screenshot,把配置文件中原有的screenshot-path "..."那一行替换为：screenshot-path null
`修改原快捷键`
```
// 区域截图
Mod+Shift+S { screenshot; }

// 当前显示器截图
Mod+Shift+A { screenshot-screen; }

// 当前窗口截图
Mod+Shift+W { screenshot-window; }
```
`配置打开剪贴板的快捷键。` 
Win + V 已用于切换窗口浮动。可以在 /home/y/.config/niri/config.kdl的 binds {}内加入：
```
Mod+Ctrl+V { spawn "dms" "ipc" "call" "clipboard" "toggle"; }
```

