
# +---------+
# | ALIASES |
# +---------+
source "$ZDOTDIR/aliases"

# +---------+
# | SCRIPTS |
# +---------+

source $ZDOTDIR/scripts.zsh

# +------------+
# | NAVIGATION |
# +------------+

setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

# +---------+
# | HISTORY |
# +---------+

setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.


# +------------+
# | COMPLETION |
# +------------+

source $ZDOTDIR/completion.zsh
source $DOTFILES/zsh-autosuggestions/zsh-autosuggestions.zsh

# +-------+
# | FONTS |
# +-------+
[ ! -d "$HOME/.fonts" ] && mkdir -p "$HOME/.fonts"
if [ ! -f "$HOME/.fonts/JetBrainsMonoNerdFont-Regular.ttf" ]; then
    FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz"
    FONT_ARCHIVE="JetBrainsMono.tar.xz"

    echo "JetBrains Mono Nerd Font not found. Downloading..."
    curl -fLo "$HOME/.fonts/$FONT_ARCHIVE" "$FONT_URL"
    tar -xf "$HOME/.fonts/$FONT_ARCHIVE" -C "$HOME/.fonts/"
    rm "$HOME/.fonts/$FONT_ARCHIVE"
    echo "JetBrains Mono Nerd Font has been installed successfully."
    fc-cache -fv "$HOME/.fonts"
fi

# +-----+
# | FZF |
# +-----+

#if [ $(command -v "fzf") ]; then
    #source $ZDOTDIR/fzf.zsh
#fi

# +--------------+
# | KEY BINDINGS |
# +--------------+

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward


# +---------------------+
# | SYNTAX HIGHLIGHTING |
# +---------------------+

source $DOTFILES/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# +--------------+
# | END OF ZSHRC |
# +--------------+

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Better cd
eval "$(zoxide init --cmd cd zsh)"

# Better prompt
eval "$(starship init zsh)"


