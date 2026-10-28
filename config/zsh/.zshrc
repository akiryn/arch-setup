# ── 历史记录 ──────────────────────────────────
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE

# ── Tab 补全 ──────────────────────────────────
# zsh-completions 由 pacman 安装到默认搜索路径，无需额外 source
autoload -Uz compinit
compinit

# ── 编辑按键 ──────────────────────────────────
# 明确使用 Emacs 风格，不随 EDITOR 环境变量改变
bindkey -e

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
