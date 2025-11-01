if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
export EDITOR=nvim

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting history)

source $ZSH/oh-my-zsh.sh

# Evals
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# Custom exports
export PATH=/home/osaka/.local/bin:$PATH
export PATH=$PATH:/home/osaka/.spicetify

# Aliases
alias pipes="$HOME/.config/pipes.sh/pipes.sh"
alias bat="bat --theme base16"

# fzf
source <(fzf --zsh)
export FZF_DEFAULT_OPTS="-m --preview='bat --color=always {}'"
