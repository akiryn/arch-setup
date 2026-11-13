# 安装kde桌面
## 安装组件
```bash
sudo pacman -S plasma-meta konsole dolphin kate firefox qt6-multimedia-ffmpeg
```
- plasma-meta是一套比较全面的kde桌面套件，本身几乎不含文件，它的作用是通过依赖把组件装齐
- konsole，dolphin，kate分别是 KDE 标配终端仿真器，文件管理器，文本编辑器
- qt6-multimedia-ffmpeg是 Qt6 的音视频后端，让使用 Qt Multimedia 的应用通过 FFmpeg 播放、解码和录制媒体

|组件|作用|
|---|---|
|`ffmpeg`|实际处理音视频编码、解码等|
|`qt6-multimedia`|为 Qt 应用提供统一的音视频接口|
|`qt6-multimedia-ffmpeg`|把 Qt 的接口连接到 FFmpeg|
|PipeWire|管理声音设备、音频流等|

## 开启显示管理器
plasma-meta的其中一项依赖是plasmalogin
```bash
sudo systemctl enable --now plasmalogin
```

## 设置系统语言
如果是archinstall安装先执行：
```bash
sudo vim /etc/locale.gen
```
取消 `zh_CN.UTF-8` 的注释。再执行
```bash
sudo locale-gen
```
预期配置目标：桌面环境及图形应用界面使用中文，系统基础语言环境、命令行工具及系统日志保持英文，尽量保持最小范围内替换英文为中文
查看系统语言环境
```bash
locale
localectl
```
`locale`:当前终端进程的语言环境。
`localectl`:系统默认语言，可能被用户或桌面设置覆盖
```bash
#在 Plasma 中分别设置语言和格式
vim ~/.config/plasma-localerc
#修改LANGUAGE值
```

```
[Translations]
LANGUAGE=zh_CN:en_US
```
plasma通过会话启动程序管理,在桌面启动早期准备语言环境,这种管理方式后续所有和plasma桌面相关的都可以很好得继承环境
会话启动程序，就是你登录后，负责把整个桌面组织起来的“开场负责人”。可以理解为：从你登录桌面，到你注销桌面，这一段使用过程，以及为你运行的一组程序。

结合niri启动流程对比见下：

| 对比       | niri＋`environment.d`    | Plasma＋`plasma-localerc`       |
| -------- | ----------------------- | ------------------------------ |
| 谁读取      | systemd 的用户环境生成器        | Plasma 会话启动程序                  |
| 主要用途     | 设置通用环境变量，语言只是其中一种       | 设置 Plasma 的语言和区域格式             |
| 环境如何传播   | 用户服务管理器 → niri、DMS → 应用 | Plasma 准备环境 → 同步服务启动环境 → 桌面和应用 |
| 是否依赖特定桌面 | 不专属于 niri               | 属于 Plasma 配置体系                 |
| 作用范围     | 获得该环境的用户服务及后代进程         | Plasma 会话及获得其启动环境的程序           |
|          |                         |                                |


如果中文字体乱码：
```bash
sudo pacman -Syu --needed noto-fonts noto-fonts-cjk noto-fonts-emoji
```

## 生成home下目录（可选）
```shell
LANG=en_US.UTF-8 xdg-user-dirs-update --force
```

这段命令将强制生成英文的 home 下常用目录，方便终端中使用。如果已经存在中文的 home 下常用目录运行这段命令后删除中文的。