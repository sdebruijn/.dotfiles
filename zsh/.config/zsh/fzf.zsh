#!/usr/bin/env zsh

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

source /usr/share/fzf/key-bindings.zsh

# Rebind ALT-c to CTRL-e
bindkey -rM emacs '\ec'
bindkey -rM vicmd '\ec'
bindkey -rM viins '\ec'

zle     -N              fzf-cd-widget
bindkey -M emacs '\C-e' fzf-cd-widget
bindkey -M vicmd '\C-e' fzf-cd-widget
bindkey -M viins '\C-e' fzf-cd-widget

source /usr/share/fzf/completion.zsh

source $DOTFILES/zsh/scripts_fzf.zsh # fzf Scripts
_fzf_comprun() {
    local command=$1
    shift

    case "$command" in
        cd)           find . -type d | fzf --preview 'tree -C {}' "$@";;
        *)            fzf "$@" ;;
    esac
}

_fzf_compgen_path() {
    rg --files --glob "!.git" "$1"
}

_fzf_compgen_dir() {
   fd --type d --hidden --follow --exclude ".git" "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    tree)         find . -type d | fzf --preview 'tree -C {}' "$@";;
    *)            fzf "$@" ;;
  esac
}


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
