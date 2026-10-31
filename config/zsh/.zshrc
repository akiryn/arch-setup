# ── 历史记录 ──────────────────────────────────
# 历史记录文件：退出时保存，也供多个终端共享历史记录。
HISTFILE="$HOME/.zsh_history"
# 当前 Shell 在内存中保留的历史记录条数。
HISTSIZE=50000
# 保存到历史文件的记录条数。
SAVEHIST=50000

# 保存命令的开始时间和执行耗时，便于后续查询。
setopt EXTENDED_HISTORY
# 将新命令追加到历史文件，并从文件导入其他终端写入的历史记录。
setopt SHARE_HISTORY
# 新命令与已有记录重复时，删除旧记录，保留最新的一条。
setopt HIST_IGNORE_ALL_DUPS
# 写入历史文件时省略重复命令。
setopt HIST_SAVE_NO_DUPS
# 使用 zsh 内置历史搜索时，不反复显示相同的命令。
setopt HIST_FIND_NO_DUPS
# 记录命令前，去掉命令中多余的空白。
setopt HIST_REDUCE_BLANKS
# 以空格开头的命令不保留在历史记录中；这不是保密机制。
setopt HIST_IGNORE_SPACE

# ── 交互式注释 ────────────────────────────────
setopt INTERACTIVE_COMMENTS


# ── Tab 补全 ──────────────────────────────────
autoload -Uz compinit
compinit

# ── 编辑按键 ──────────────────────────────────
bindkey -v
KEYTIMEOUT=10
# 仅调整 Vi 插入模式
bindkey -M viins '^F' autosuggest-accept
bindkey -M viins '^[f' forward-word

# ── 历史输入建议 ──────────────────────────────
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# ── fzf：历史搜索、文件选择、目录选择 ──────────
source <(fzf --zsh)

# ── zoxide：使用 z / zi 跳转目录 ───────────────
eval "$(zoxide init zsh)"

# ── Starship 提示符 ───────────────────────────
eval "$(starship init zsh)"

# ── 语法高亮：保持最后加载 ─────────────────────
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh