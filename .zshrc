if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source ~/powerlevel10k/powerlevel10k.zsh-theme

# ZSH_THEME="apple"
# ZSH_THEME="powerlevel10k/powerlevel10k"


plugins=(git
         github)

source $ZSH/oh-my-zsh.sh
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

if (( ! ${fpath[(I)/usr/local/share/zsh/site-functions]} )); then
  FPATH=/usr/local/share/zsh/site-functions:$FPATH
fi

alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias t="tmux"
alias n="nvim"
alias sm="htop"
alias fm="ranger"
alias la="lsd -al"
alias l="lsd -a"
alias fetch="neofetch"
alias ga="git add ."
alias gs="git status -s"
alias gc="(){git commit -m $1}"
alias gp="git push"

alias c="clear"
alias e="exit"

eval "$(starship init zsh)"




# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/melih/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/melih/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/melih/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/melih/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
export PATH=$PATH:/usr/local/go/bin:~/go/bin/
export PATH=$PATH:~/rofi-bluetooth/


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
