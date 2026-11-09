**Waypaper 是选择壁纸的图形界面，awww 是实际显示和切换壁纸的后端。**

它们配合时，流程如下。

```
你在 Waypaper 中选择图片
          ↓
Waypaper 调用 awww
          ↓
awww 将图片显示为桌面壁纸，并处理切换动画
```

|工具|主要职责|
|---|---|
|Waypaper|浏览壁纸、选择图片、保存壁纸设置|
|awww|设置各显示器的壁纸、执行过渡动画|
|awww-daemon|在后台持续运行，负责呈现壁纸|

Waypaper 可以配合不同壁纸后端，awww 是其中一种。awww 也可以独立通过命令行使用，无需打开 Waypaper。

## 概览实现模糊壁纸

```
Waypaper 切换普通桌面壁纸
          ↓
post_command 调用处理脚本
          ↓
ImageMagick 生成暗色模糊版本
          ↓
名为 overview 的 awww 实例显示处理后的图片
          ↓
Niri 将这个图层放进概览背景
```
Waypaper/config.ini配置文件
```ini
backend = awww

post_command = $HOME/.config/scripts/ $HOME/.config/scripts/niri_set_overview_blur_dark_bg.sh
```
这里依次执行配色更新、等待 `0.8` 秒、生成概览背景。

注意使用了 `&&`，因此前面的配色更新若失败，后面的概览背景脚本也不会运行。

