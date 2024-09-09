VISUAL=nvim
EDITOR="$VISUAL"
declare -A ZINIT
ZINIT[NO_ALIASES]=1

# Download Zinit, if it's not there yet
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Install nerdfont
[ ! -d "$HOME/.fonts" ] && mkdir -p "$HOME/.fonts"
if [ ! -f "$HOME/.fonts/JetBrainsMonoNerdFont-Regular.ttf" ]; then
	FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz"
	FONT_ARCHIVE="JetBrainsMono.tar.xz"

	curl -fLo "$HOME/.fonts/$FONT_ARCHIVE" "$FONT_URL"
	tar -xf "$HOME/.fonts/$FONT_ARCHIVE" -C "$HOME/.fonts/"
	rm "$HOME/.fonts/$FONT_ARCHIVE"
	echo "JetBrains Mono Nerd Font has been installed successfully."
	fc-cache -fv "$HOME/.fonts"
fi

# Install ohmyposh if not installed
if [ ! -f "/usr/local/bin/oh-my-posh" ]; then
	echo "Asking for permission to download ohmyposh"
	curl -s https://ohmyposh.dev/install.sh | sudo bash -s
fi

eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

# Add in zsh plugins
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Add in snippets
zinit snippet OMZP::git
#zinit snippet OMZP::docker
#zinit snippet OMZP::docker-compose
#zinit snippet OMZP::sudo
#zinit snippet OMZP::aws
#zinit snippet OMZP::kubectl
#zinit snippet OMZP::kubectx
#zinit snippet OMZP::command-not-found

#zinit cdreplay -q

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q


# Keybindings emacs mode
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Autocomplete colors
#
# Based on the oh-my-zsh default `LSCOLORS`. Converted with the help of the
# Geoff Greer's lscolors project.
# See: https://geoff.greer.fm/lscolors/
_ls_colors="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*:default' list-colors "${(s.:.)_ls_colors}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"
alias vimdiff="nvim -d"

alias ofload='cd ~/ofload/ofload_site'

# Shell integrations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)" # Only from fzf version 0.48.0. Do manual:
#source /usr/share/doc/fzf/examples/key-bindings.zsh
#source /usr/share/doc/fzf/examples/completion.zsh
source <(kubectl completion zsh)
eval "$(zoxide init --cmd cd zsh)"

choose_aws_profile() {
  # Extract profile names from the AWS config file
  selected_profile=$(
    sed -n "s/\[profile \(.*\)\]/\1/gp" ~/.aws/config \
    | fzf \
    --height=20% \
    --min-height=12 \
    --margin=5%,2%,2%,5% \
    --border=rounded \
    --info=inline \
    --header="Choose AWS profile" \
  )
  export AWS_PROFILE=$selected_profile
  echo "Set AWS profile to '$selected_profile'"
}
alias awsprofile='choose_aws_profile'


alias fixperm='sudo chown $(id -nu):www-data -R ./storage && sudo chmod -R g+wr ./storage'

fixperms () {
    dir="${1:-$(pwd)}"
    sudo chown -R $(whoami) $dir
    sudo chgrp -R dockersijmen $dir
    sudo chmod -R g+w $dir
    sudo chmod -R g+r $dir
}

#compdef redocly
###-begin-redocly-completions-###
#
# yargs command completion script
#
# Installation: redocly completion >> ~/.zshrc
#    or redocly completion >> ~/.zsh_profile on OSX.
#
_redocly_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" redocly --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _redocly_yargs_completions redocly
###-end-redocly-completions-###


export DOCKER_GATEWAY_HOST="`docker network inspect app-network -f '{{ (index .IPAM.Config 0).Gateway }}'`"


