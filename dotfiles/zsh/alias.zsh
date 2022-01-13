#!/usr/bin/env zsh

# EDITOR
hash nvim 2>/dev/null && {
    alias vim="nvim"
    alias vi="nvim"
}

hash emacs 2>/dev/null && {
    alias e="emacsclient -a \"\" -c"
    alias en="emacsclient -a \"\" -c -nw"
    alias ec="emacs"
    alias ecn="emacs -nw"
    alias todo="emacs -nw ~/org/todo.org"
}


# Basic
alias ls="ls --color"
alias ll="ls -l"
alias la="ls -al"
hash trash 2>/dev/null && {
    alias rm="trash"
}
alias mkdir="mkdir -p"
alias grep="grep --color"
alias cp="cp -i"
alias df="df -h"
alias du="du -h"
alias free="free -m"
alias more=less
alias ~="cd ~"
alias :q="exit"
alias ..="cd .."
alias up="cd .."

# Misc Program
alias ra="ranger"
alias dotdrop="~/.dotfile/dotdrop.sh --cfg=~/.dotfile/config.yaml"
alias g="git"
# alias docker="sudo docker"
alias pcs="proxychains"
alias qrsd.fzf='qrcp send "$(fzf)"'
alias qrsd='qrcp send'
alias qrrv="qrcp receive"
alias pbcopy="xsel --clipboard --input"
alias pbpaste="xsel --clipboard --output"

function wine-use-container(){
    prefix=$1
    prog=$2
    echo -n "Args: "
    read -A args
    eval "WINEPREFIX=\"$HOME/.wine/$prefix\" wine $prog $args"
}
alias wine-in-common='wine-use-container common'

function setpxy(){

	host_name="127.0.0.1"
	if [[ "$HOST" -eq "mslxl-LAPTOP" ]]; then
		host_name="mslxl-LAPTOP.local"
	fi
    echo "Set proxy as $host_name:1080/1081"
	export ALL_PROXY="socks5://$host_name:1080"
    export all_proxy="socks5://$host_name:1080"
	export http_proxy="http://$host_name:1081"
	export https_proxy="http://$host_name:1081"
	# git config --global http.proxy "$http_proxy"
	# git config --global https.proxy "$https_proxy"
    hash cgproxy 2>/dev/null && {
        echo "Start cgproxy"
        systemctl status cgproxy > /dev/null
        if [[ "$?" -ne 0 ]]; then
            sudo systemctl start cgproxy
        fi
    }
}
function unsetpxy(){
	# git config --global --unset http.proxy
	# git config --global --unset https.proxy
	unset ALL_PROXY http_proxy https_proxy
    	hash cgproxy 2>/dev/null && {
        systemctl status cgproxy > /dev/null
        if [[ "$?" -eq 0 ]]; then
            sudo systemctl stop cgproxy
        fi
    }
}

# Tmux
hash tmux 2>/dev/null && {
    alias t="tmux"
    alias tls="tmux ls"
    alias tatt="tmux attach -t"
    alias tnew="tmux new -t"
}
