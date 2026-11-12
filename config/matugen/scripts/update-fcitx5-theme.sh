#!/usr/bin/env bash
set -euo pipefail

theme_dir="$HOME/.local/share/fcitx5/themes/Matugen"
theme_file="$theme_dir/theme.conf"

# 从已生成的主题中读取指定节的 Color。
read_color() {
    awk -v section="[$1]" '
        /^\[/ { active = ($0 == section) }
        active && /^Color=/ {
            sub(/^Color=/, "")
            sub(/\r$/, "")
            print
            exit
        }
    ' "$theme_file"
}

panel_color=$(read_color "InputPanel/Background")
highlight_color=$(read_color "InputPanel/Highlight")

for color in "$panel_color" "$highlight_color"; do
    if [[ ! "$color" =~ ^#[[:xdigit:]]{6}$ ]]; then
        printf '无效的主题颜色：%s\n' "$color" >&2
        exit 1
    fi
done

write_svg() {
    local name="$1"
    local color="$2"

    cat > "$theme_dir/$name.tmp" <<EOF
<svg width="39" height="39" xmlns="http://www.w3.org/2000/svg">
  <rect width="39" height="39" rx="8" fill="$color"/>
</svg>
EOF

    mv "$theme_dir/$name.tmp" "$theme_dir/$name"
}

write_svg panel.svg "$panel_color"
write_svg highlight.svg "$highlight_color"

# 未运行时跳过刷新，不启动输入法。
if ! pgrep -u "$(id -u)" -x fcitx5 >/dev/null; then
    exit 0
fi

busctl --user --auto-start=no call \
    org.fcitx.Fcitx5 \
    /controller \
    org.fcitx.Fcitx.Controller1 \
    ReloadAddonConfig s classicui
