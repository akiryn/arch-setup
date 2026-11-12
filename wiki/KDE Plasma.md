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

系统设置 > Region & Language > Language 边上的 Modify > 点击 Add More 添加简体中文 > 移动到 English 上方

如果中文字体乱码：
```bash
sudo pacman -Syu --needed noto-fonts noto-fonts-cjk noto-fonts-emoji
```

## 生成home下目录（可选）
```shell
LANG=en_US.UTF-8 xdg-user-dirs-update --force
```

这段命令将强制生成英文的 home 下常用目录，方便终端中使用。如果已经存在中文的 home 下常用目录运行这段命令后删除中文的。