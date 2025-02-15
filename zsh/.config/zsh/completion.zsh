# +---------+
# | General |
# +---------+

# Load more completions
fpath=($DOTFILES/zsh-completions/src $fpath)

# Should be called before compinit
zmodload zsh/complist


autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files


_ls_colors="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# +---------+
# | zstyles |
# +---------+

# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate

# Use cache for commands using cacheximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

# Complete the alias when _expand_alias is used as a function
zstyle ':completion:*' complete true

zle -C alias-expension complete-word _generic
bindkey '^Xa' alias-expension
zstyle ':completion:alias-expension:*' completer _expand_alias

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*:default' list-colors "${(s.:.)_ls_colors}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

