参考文档 [Kitty 官方配置文档](https://sw.kovidgoyal.net/kitty/conf/?utm_source=chatgpt.com)   [Arch Linux kitty.conf 手册](https://man.archlinux.org/man/kitty.conf.5.en?utm_source=chatgpt.com) [Kitten 工具介绍](https://sw.kovidgoyal.net/kitty/kittens_intro/?utm_source=chatgpt.com)





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

## 3. Nerd Font 与特殊字符

- Nerd Font：添加大量开发工具图标字形的字体。
- `symbol_map`：将 Unicode 字符或字符范围映射到指定字体。
- `narrow_symbols`：调整特定符号的单元格宽度处理。

## 4. 字体连字

- `disable_ligatures never`：不禁用连字。
- `disable_ligatures always`：禁用连字。
- `disable_ligatures cursor`：光标位置附近禁用连字。
- `font_features`：控制字体的 OpenType 特性。
- 连字只影响视觉呈现，不改变实际文本。

## 5. 常用命令

```bash
kitty +list-fonts
fc-match "JetBrainsMono Nerd Font"
```

## 6. 当前个人配置

```ini
font_family JetBrainsMono Nerd Font
font_size 12.0
```

建议保持自动字形匹配，按需要再调整字符间距、连字和符号映射。








## kittens


| kitty   | 终端模拟器            |
| ------- | ---------------- |
| Kitten  | 调用辅助功能的命令行入口     |
| Kittens | Kitty 提供的一系列辅助工具 |
