# Luke's config for the Zoomer Shell

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
# Base16 Shell
       
# Removes ugly colors for highlights
export LS_COLORS="$LS_COLORS:ow=2;34:tw=1;34:"


PROMPT="%K{249}%F{238}%n%f%k%K{253}%F{249}%f%k%K{253}%F{238}%(3~|.../%2~|%~)%f%k%F{253}%f %F{240}%f "

setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.zshhistory

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"

# Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# BashCompinit
autoload -U +X bashcompinit && bashcompinit

# Autocomplete for pipx
eval "$(register-python-argcomplete pipx)"
# Autocomplete for haskell
eval "$(stack --bash-completion-script stack)"

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

bindkey -s '^a' 'bc -lq\n'

bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
# If not running interactively, don't do anything
export PATH=$PATH:~/.local/bin

alias lf="~/.local/bin/lfub"

# Beautiful ls command with exa
alias ll="exa -lgh --icons --group-directories-first"
alias la="exa -lgha --icons --group-directories-first"


# Fixing TMUX icons
alias xx="tmux -u"

alias d:="cd /run/media/aditya/New\ Volume"

# Loads NVM
#source /usr/share/nvm/init-nvm.sh

export EDITOR=/usr/bin/nvim
export PATH=$PATH:/home/aditya/.meteor
export PATH=$PATH:"$HOME/.pub-cache/bin"

# Flutter
export CHROME_EXECUTABLE="google-chrome-stable"
export PATH=$PATH:run/media/aditya/43ea9c7c-e1a5-4610-a2eb-9cdd424da4f2/opt/flutter/bin

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Created by `pipx` on 2023-08-15 09:57:28 export PATH="$PATH:/home/aditya/.local/bin"
source ~/.nvm/nvm.sh

# Dotnet tools
export PATH="$PATH:/home/aditya/.dotnet/tools"

#Helix
alias hx="helix"
HELIX_RUNTIME="~/.config/helix/runtime"

