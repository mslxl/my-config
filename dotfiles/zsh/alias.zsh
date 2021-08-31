#!/usr/bin/env zsh

# EDITOR
alias vim="nvim"
alias vi="nvim"

alias e="emacsclient -a \"\" -c"
alias en="emacsclient -a \"\" -c -nw"
alias ec="emacs"
alias ecn="emacs -nw"
alias todo="emacs -nw ~/org/todo.org"

# Basic
alias ls="ls --color"
alias ll="ls -l"
alias la="ls -al"
alias rm="trash"
alias mkdir="mkdir -p"
alias grep="grep --color"
alias cp="cp -i"
alias df="df -h"
alias free="free -m"
alias more=less
alias ~="cd ~"
alias :q="exit"

# Misc Program
alias ra="ranger"
alias dotdrop="~/.dotfile/dotdrop.sh --cfg=~/.dotfile/config.yaml"
alias g="git"
alias docker="sudo docker"
alias pcs="proxychains"
alias qrsd="qrcp send"
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

function setpro(){
	ALL_PROXY="socks5://127.0.0.1:1080"
	http_proxy="http://127.0.0.1:1081"
	https_proxy="http://127.0.0.1:1081"
	# git config --global http.proxy "$http_proxy"
	# git config --global https.proxy "$https_proxy"
    systemctl status cgproy > /dev/null
    if [[ "$?" -ne 0 ]]; then
        systemctl start cgproxy
    fi
}
function unsetpro(){
	# git config --global --unset http.proxy
	# git config --global --unset https.proxy
	unset ALL_PROXY http_proxy https_proxy
    systemctl status cgproxy > /dev/null
    if [[ "$?" -eq 0 ]]; then
        systemctl stop cgproxy
    fi
}

# ps
alias ps.find="ps aux | grep -v 'grep' | grep"
alias ps.find.cmd="ps aux | grep -v 'grep' | awk '{print \$11\" \"\$12}' | grep"
alias ps.fzf="ps aux | fzf"
alias ps.fzf.cmd="ps.fzf | awk '{print \$11\" \"\$12}'"
alias ps.fzf.pid="ps.fzf | awk '{print \$2}'"
alias ps.fzf.kill="ps.fzf.pid | xargs kill"

# Tmux
alias t="tmux"
alias tls="tmux ls"
alias tatt="tmux attach -t"
alias tnew="tmux new -t"
