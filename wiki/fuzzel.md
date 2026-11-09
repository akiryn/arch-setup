查看本机安装了哪些fuzzel相关的手册
```bash
apropos fuzzel
```

```
fuzzel (1)           - Wayland app launcher and picker
fuzzel.ini (5)       - configuration file for fuzzel(1)
```

# main配置段
```ini
# 字体
font='JetBrainsMono Nerd Font Mono:size=12,Noto Sans CJK SC:size=12'
# 粗体
use-bold=yes
# 输入框为空时显示的提示文字
placeholder=
# 根据桌面环境过滤显示项
filter-desktop=yes
# Fuzzel 打开时独占键盘焦点。改为 on-demand 后，可以像普通窗口一样通过点击其他窗口切走焦点。
keyboard-focus=on-demand
# Fuzzel 一旦失去键盘焦点就自动关闭。改为no
exit-on-keyboard-focus-loss=no
```



# 快捷键相关配置
The search box supports Emacs-like key bindings.采用Emacs风格快捷键

> 一些按键对应标示的说明

	bracketleft -> [
	KP_ -> 小键盘
	XF86Paste -> 专用的复制按键
	ISO_Left_Tab -> Shift + Tab
	Mod1 -> Alt
	Mod4 -> Super/Win
	exclam -> !
	at -> @
	numbersign -> #
	 dollar -> $
	 percent -> %
	 dead_circumflex -> ^
	 ampersand -> &
	 asterix -> *
	 parentleft -> (
	

> 一些前缀标示的说明

	execute 执行
	execute-or-next 切换到下一项
	execute-input 强制执行输入（忽略当前列表中选中的项）
	

```ini
[key-bindings]
execute-input=Shift+Return

# cancel=Escape Control+g Control+c Control+bracketleft
# execute=Return KP_Enter Control+y
# execute-or-next=Tab
# execute-input=Shift+Return Shift+KP_Enter
# cursor-left=Left Control+b
# cursor-left-word=Control+Left Mod1+b
# cursor-right=Right Control+f
# cursor-right-word=Control+Right Mod1+f
# cursor-home=Home Control+a
# cursor-end=End Control+e
# delete-line=Control+Shift+BackSpace
# delete-prev=BackSpace Control+h
# delete-prev-word=Mod1+BackSpace Control+BackSpace Control+w
# delete-line-backward=Control+u
# delete-next=Delete KP_Delete Control+d
# delete-next-word=Mod1+d Control+Delete Control+KP_Delete
# delete-line-forward=Control+k
# prev=Up Control+p
# prev-with-wrap=ISO_Left_Tab
# prev-page=Page_Up KP_Page_Up
# next=Down Control+n
# next-with-wrap=none
# next-page=Page_Down KP_Page_Down
# expunge=Shift+Delete
# clipboard-paste=Control+v XF86Paste
# primary-paste=Shift+Insert Shift+KP_Insert

# custom-N: *dmenu mode only*. Like execute, but with a non-zero
# exit-code; custom-1 exits with code 10, custom-2 with 11, custom-3
# with 12, and so on.

# custom-1=Mod1+1
# custom-2=Mod1+2
# custom-3=Mod1+3
# custom-4=Mod1+4
# custom-5=Mod1+5
# custom-6=Mod1+6
# custom-7=Mod1+7
# custom-8=Mod1+8
# custom-9=Mod1+9
# custom-10=Mod1+0
# custom-11=Mod1+exclam
# custom-12=Mod1+at
# custom-13=Mod1+numbersign
# custom-14=Mod1+dollar
# custom-15=Mod1+percent
# custom-16=Mod1+dead_circumflex
# custom-17=Mod1+ampersand
# custom-18=Mod1+asterix
# custom-19=Mod1+parentleft
```
