# Niri 音频控制与 SwayOSD 配置

## 1. 音频组件及其职责

在使用 PipeWire 的桌面环境中，音频服务、设备管理和控制工具分别承担不同职责。

| 组件             | 职责                                                      |
| -------------- | ------------------------------------------------------- |
| ALSA           | Linux 音频驱动和用户空间接口体系，PipeWire 通常通过它访问本机声卡                |
| PipeWire       | 处理音频流，也支持视频流                                            |
| WirePlumber    | PipeWire 的会话管理器，管理设备、连接、默认设备等策略                         |
| pipewire-pulse | 提供 PulseAudio 兼容接口，使使用该接口的程序能够连接 PipeWire               |
| PulseAudio     | 另一套音频服务；当前使用 PipeWire 与 pipewire-pulse 时，无需为了兼容应用而另行运行它 |

### 1.1 命令行与图形化控制工具

|工具|作用|控制方式|
|---|---|---|
|`wpctl`|查询和调整音量、静音状态及音频对象|WirePlumber 提供的命令行工具|
|Pavucontrol|调整应用音量、输出设备、麦克风及设备配置|通过 PulseAudio 兼容接口连接当前音频系统|

本机使用 PipeWire，因此 Pavucontrol 通过 `pipewire-pulse` 兼容工具工作。

## 2. SwayOSD 的作用

SwayOSD 用于在调节音量、亮度等操作时显示屏幕提示，例如扬声器图标和音量百分比。

它包含两个主要程序：

|程序|作用|
|---|---|
|`swayosd-server`|常驻后台，处理请求、执行相应操作并显示提示|
|`swayosd-client`|发送操作请求，例如降低音量、切换静音|

### 2.1 与原有音频控制方式的区别

原有 Niri 快捷键直接调用 `wpctl`：

```
Niri 快捷键
  → wpctl
  → 使用 WirePlumber 提供的控制能力
  → 控制 PipeWire 音频对象
```

改用 SwayOSD 后：

```
Niri 快捷键
  → swayosd-client
  → swayosd-server
  → PulseAudio 接口
  → pipewire-pulse
  → PipeWire
```

SwayOSD 不需要调用 `wpctl`。WirePlumber 仍负责音频设备和连接策略，而 SwayOSD 通过 PulseAudio 兼容接口发送音量、静音请求。

两种方式控制的是同一套音频系统，因此调节结果也会反映在 Waybar 中。主要区别是 SwayOSD 额外提供屏幕提示。

## 3. 安装 SwayOSD

```
sudo pacman -S --needed swayosd
```

## 4. 启动后台程序

### 4.1 随 Niri 会话自动启动

编辑 Niri 主配置：

```
vim ~/.config/niri/config.kdl
```

在顶层自启动区域加入：

```
spawn-at-startup "swayosd-server"
```

这条配置在启动 Niri 会话时执行。保存配置不会立即执行新增的自启动命令。

### 4.2 在当前会话立即启动

```
swayosd-server > /tmp/swayosd.log 2>&1 &
```

|写法|含义|
|---|---|
|`> /tmp/swayosd.log`|将标准输出写入日志文件，覆盖原内容|
|`2>&1`|将错误输出也写入同一日志|
|`&`|后台运行，释放终端供后续操作|

检查进程：

```
pgrep -a swayosd-server
```

如果已经运行，无需重复启动。

## 5. 配置 Niri 快捷键

编辑快捷键文件：

```
vim ~/.config/niri/binds.kdl
```

以下绑定应放在已有的 `binds { ... }` 内，并替换对应的旧绑定，避免同一个按键重复定义。

### 5.1 音量与静音

原有配置使用 `wpctl`，例如：

```
XF86AudioRaiseVolume allow-when-locked=true {
    spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0";
}
```

改为 SwayOSD：

```
// 增加输出音量，每次 10 个百分点，上限 100%
XF86AudioRaiseVolume allow-when-locked=true {
    spawn "swayosd-client" "--output-volume" "+10" "--max-volume" "100";
}

// 降低输出音量，每次 10 个百分点
XF86AudioLowerVolume allow-when-locked=true {
    spawn "swayosd-client" "--output-volume" "-10";
}

// 切换输出静音
XF86AudioMute allow-when-locked=true {
    spawn "swayosd-client" "--output-volume" "mute-toggle";
}

// 切换麦克风静音
XF86AudioMicMute allow-when-locked=true {
    spawn "swayosd-client" "--input-volume" "mute-toggle";
}
```

`allow-when-locked=true` 表示锁屏时仍允许使用这些按键。

`spawn` 直接启动程序，程序名和每个参数分别使用引号包围；这里没有管道、条件判断等 Shell 语法，因此不需要使用 `spawn-sh`。

### 5.2 屏幕亮度

原有配置直接调用 `brightnessctl`：

```
XF86MonBrightnessUp allow-when-locked=true {
    spawn "brightnessctl" "--class=backlight" "set" "+10%";
}
```

改为 SwayOSD：

```
// 增加亮度
XF86MonBrightnessUp allow-when-locked=true {
    spawn "swayosd-client" "--brightness" "+10";
}

// 降低亮度
XF86MonBrightnessDown allow-when-locked=true {
    spawn "swayosd-client" "--brightness" "-10";
}
```

亮度调节仍需要可用的背光设备及相应权限。笔记本内屏背光与外接显示器的 DDC/CI 亮度控制属于不同机制。

## 6. 验证配置

检查 Niri 配置：

```
niri validate
```

确认 SwayOSD 后台运行后，手动测试降低输出音量：

```
swayosd-client --output-volume -10
```

再测试键盘上的音量、静音和亮度键，确认：

- 实际音量或亮度发生变化。
- 屏幕出现对应提示。
- Waybar 音量显示同步变化。

如果手动命令有效、按键无效，检查 Niri 快捷键；如果客户端无法连接服务，检查 `swayosd-server` 进程及日志：

```
cat /tmp/swayosd.log
```

> SwayOSD 不是对所有音量变化的自动提示器。直接使用 `wpctl` 或其他工具调节时，不会出现 SwayOSD 提示；通过 `swayosd-client` 发起操作，才会走这里配置的提示流程。




# 待整理

`swayosd-libinput-backend`这是一个`swayosd-server` 的可选后台将其启动可以给大小写切换也添加指示图标
```
sudo systemctl enable --now swayosd-libinput-backend.service
```

`pw-play` 是 PipeWire 提供的命令行音频播放工具。它读取音频文件，将音频送入 PipeWire，再由音频系统送到输出设备。

```
pw-play /路径/音频文件
```

在你的桌面环境中，可以把过程理解为：

```
pw-play 读取音效
 → PipeWire 音频流
 → 根据当前设备与路由设置
 → 耳机或扬声器
```

它与前面几个命令的区别是：

| 命令          | 职责                      |
| ----------- | ----------------------- |
| `pw-play`   | 播放声音                    |
| `wpctl`     | 调节音量、静音、默认设备等           |
| `playerctl` | 控制支持 MPRIS 的播放器播放、暂停、切歌 |


