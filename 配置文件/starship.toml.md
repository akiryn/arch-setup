```toml
# Based on Downloads/.p10k.zsh: single-line Rainbow / angled Powerline.
"$schema" = 'https://starship.rs/config-schema.json'
add_newline = false
format = '$os[](fg:7 bg:4)$directory${custom.directory_tail}($git_branch$git_commit$git_status$git_state[](fg:2)) '
right_format = '$status$cmd_duration$jobs$python$conda$username$hostname'

[os]
disabled = false
format = '[ $symbol ]($style)'
style = 'fg:232 bg:7'
[os.symbols]
Arch = ''

[directory]
format = '[ $path$read_only ]($style)'
style = 'bold fg:254 bg:4'
truncation_length = 4
truncation_symbol = '…/'
truncate_to_repo = true
read_only = ' '

[status]
disabled = false
format = '$symbol'
style = 'fg:1 bg:0'
success_style = 'fg:2 bg:0'
failure_style = 'fg:1 bg:0'
symbol = '[](fg:0)[ ✘ $status ](fg:1 bg:0)'
success_symbol = '[](fg:0)[ ✔ ](fg:2 bg:0)'

[cmd_duration]
min_time = 3000
# Match the preceding status background to avoid a transparent notch.
format = '[](fg:3 bg:0)[ $duration  ]($style)'
style = 'fg:0 bg:3'

[jobs]
format = '[](fg:0)[ $symbol$number ]($style)'
style = 'fg:6 bg:0'
symbol = ' '
number_threshold = 2
symbol_threshold = 1

[python]
format = '([](fg:0)[ $virtualenv  ](fg:4 bg:0))'
[conda]
format = '[](fg:0)[ $environment  ](fg:4 bg:0)'
ignore_base = true
[username]
format = '[](fg:0)[ $user ]($style)'
style_user = 'fg:3 bg:0'
style_root = 'fg:1 bg:0'
show_always = false
[hostname]
format = '[@$hostname ]($style)'
style = 'fg:3 bg:0'
ssh_only = true

# Native Starship Git modules. Background stays green in every state.
[git_branch]
format = '[](fg:4 bg:2)[  $branch ]($style)'
style = 'fg:0 bg:2'
[git_commit]
format = '[ @$hash ]($style)'
style = 'fg:0 bg:2'
only_detached = true
[git_status]
format = '([ $all_status$ahead_behind ]($style))'
style = 'bold fg:0 bg:2'
conflicted = '=${count}'
ahead = '⇡${count}'
behind = '⇣${count}'
diverged = '⇕⇡${ahead_count}⇣${behind_count}'
untracked = '?${count}'
stashed = '*${count}'
modified = '!${count}'
staged = '+${count}'
renamed = '»${count}'
deleted = '✘${count}'
[git_state]
format = '[ $state( $progress_current/$progress_total) ]($style)'
style = 'bold fg:0 bg:2'

# Only controls the directory end cap outside Git; no Git status parsing.
[custom.directory_tail]
when = '! git rev-parse --git-dir >/dev/null 2>&1'
command = "printf ''"
shell = ['sh']
format = '[$output](fg:4)'
```