
setopt histignorealldups sharehistory

SAVEHIST=5000
HISTSIZE=5000
HISTFILE=~/.zsh_history

if [[ -f $HOME/.zplug/init.zsh ]] {
  autoload -Uz compinit && compinit

  source $HOME/.zplug/init.zsh
  source $HOME/.zsh/init.zsh

  # Theme
  if [[ "$DISPLAY" == "" ]] {
    zplug "themes/ys", from:oh-my-zsh, as:theme
  } else {
    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
    # confirmations, etc.) must go above this block; everything else may go below.
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
      source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi
    zplug romkatv/powerlevel10k, as:theme, depth:1
    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

    zplug "kutsan/zsh-system-clipboard"
  }

  zplug "~/.zsh/plugins/x", from:local
  # zplug "~/.zsh/plugins/safe_sudo", from:local
  zplug "plugins/vi-mode", from:oh-my-zsh
  zplug "plugins/z", from:oh-my-zsh
  zplug "plugins/colored-man-pages", from:oh-my-zsh
  zplug "plugins/safe-paste", from:oh-my-zsh
  zplug "zsh-users/zsh-syntax-highlighting"
  zplug "zsh-users/zsh-autosuggestions"

  # Adds autocomplete options for all adb commands.
  type adb >/dev/null 2>&1 && {
    zplug "plugins/adb", from:oh-my-zsh
  }

  type cargo >/dev/null 2>&1 && {
    zplug "plugins/rust", from:oh-my-zsh
  }

  type fzf >/dev/null 2>&1 && {
    zplug "plugins/zsh-interactive-cd", from:oh-my-zsh
  }

  # zsh history substring search
  zplug "zsh-users/zsh-history-substring-search"
  # zplug "plugins/history-substring-search", from:oh-my-zsh
  bindkey -v
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey "$terminfo[kcuu1]" history-substring-search-up
  bindkey "$terminfo[kcud1]" history-substring-search-down
  bindkey '\eOA' history-substring-search-up
  bindkey '\eOB' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
  # -------------------------


  # load plugin by zplug
  zplug 'zplug/zplug', hook-build:'zplug --self-manage'
  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi
  zplug load
} else {
  print -P "%F{red}Please install zplug."
  print -P "Run %U%Bgit clone https://github.com/zplug/zplug ~/.zplug%b%u to install"
  print -P "See:https://github.com/zplug/zplug%f"
  printf "Install? [y/N]: "
  if read -q; then
    echo
    git clone https://github.com/zplug/zplug $HOME/.zplug
  fi
}


type stack >/dev/null 2>&1 && {
  autoload -U +X bashcompinit && bashcompinit
  source <(stack --bash-completion-script stack)
}

function recompile(){
  echo -n "Compile $HOME/.zshrc...  "
  zcompile ~/.zshrc
  echo "Done"
  files=$(find ~/.zsh | grep --regexp "\w\\.zsh$" | grep -v "/plugins/" )
  for f (${=files}) {
      echo
      echo -n "Compile $f... "
      zcompile $f
      echo -n "Done"
  }
  unset files
}
