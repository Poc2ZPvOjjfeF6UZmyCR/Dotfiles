# if [[ -z "$TMUX" ]] ;then
#     ID="$( tmux ls | grep -vm1 attached | cut -d: -f1 )" # get the id of a deattached session
#     if [[ -z "$ID" ]] ;then # if not available create a new one
#         tmux new-session
#     else
#         tmux attach-session -t "$ID" # if available attach to it
#     fi
# fi


# Defines environment variables
export EDITOR="nano"
export VISUAL="nano"
export MANWIDTH=72
export SUDO_EDITOR="nano"
export PAGER=less
export CCACHE_DIR=/tmp/ccache
#export BC_ENV_ARGS=~/.bcrc
export BC_ENV_ARGS=-lq

# Set the framebuffer font to terminus
#export FBFONT=/usr/share/kbd/consolefonts/ter-216n.psf.gz

export GPG_TTY=$(tty)

# export _JAVA_AWT_WM_NONREPARENTING=1

export PATH=~/Projects/bin:~/.local/bin:$PATH
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor
#[ -x /usr/bin/lesspipe ] && eval $(lesspipe)

# Use less as sdcv's pager
export SDCV_PAGER=less

# Use Wayland for QT 5 applications
#export QT_QPA_PLATFORM=wayland-egl

if [ -n "$DISPLAY" ]; then
    export BROWSER=firefox
else
    export BROWSER=w3m
fi

source /etc/profile.d/bash_completion.sh

export HISTCONTROL=ignoreboth

source $HOME/.aliases

export XDG_CURRENT_DESKTOP=kde
export QT_QPA_PLATFORMTHEME=qt5ct
export GTK_USE_PORTAL=0

export MOZ_DISABLE_SAFE_MODE_KEY=1

#source /usr/lib/git-core/git-sh-prompt
#export GIT_PS1_SHOWDIRTYSTATE=1

#PS1='[\u@\h \W]\$ '
reset=$(tput sgr0)
red=$(tput setaf 1)
# bright_red=$(tput setaf 9)
green=$(tput setaf 2)
#doesn't work in tty...
bright_green=$(tput setaf 10)
blue=$(tput setaf 4)
# bright_blue=$(tput setaf 11)

PS1='\[$green\]\u\[$reset\] \[\e[1;34m\]\w\[\e[m\]\[$green\]$(__git_ps1 " (%s)") \$\[$reset\] '
shopt -s checkwinsize

# colored man pages
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

# cd and ls in one
cl() {
    dir=$1
    if [[ -z "$dir" ]]; then
        dir=$HOME
    fi
    if [[ -d "$dir" ]]; then
        cd "$dir"
        ls
    else
        echo "bash: cl: '$dir': Directory not found"
    fi
}

ytconvert() {
    ffmpeg -i "$1" -c:v libx264 -crf 18 -preset slow -pix_fmt yuv420p -c:a copy "$2".mkv
}

pdfcompress() {
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dBATCH  -dQUIET -sOutputFile="$2" "$1"
}

recordsound() {
    ffmpeg -f alsa -i hw:0 "$1"
}

resolve-symbolic-link() {
    if [ -L $1 ]; then
        temp="$(readlink "$1")";
        rm -rf "$1";
        cp -rf "$temp" "$1";
    fi
}

ttm() {
    echo "$*" >> ~/Documents/ttm.txt
}

# start ssh-agent and gpg-agent when needed and remember password after that
#eval `keychain --agents ssh,gpg --quiet --eval id_rsa 4CE3E585F2CCBE11`
#eval `keychain --eval --quiet --agents ssh id_rsa`
#eval `keychain --eval --quiet`
