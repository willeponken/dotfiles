HISTFILE=~/.zsh-histfile
HISTSIZE=5000
SAVEHIST=5000
setopt append_history share_history histignorealldups autocd extendedglob
setopt nomatch notify
unsetopt beep

# Vi-mode
bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward
bindkey -M vicmd "k" history-beginning-search-backward
bindkey -M vicmd "j" history-beginning-search-forward
export KEYTIMEOUT=1

# Display beam for insert mode and block for normal mode (vi-mode).
zle-keymap-select () {
	if [ $KEYMAP = vicmd ]; then
		printf "\033[2 q"
	else
		printf "\033[6 q"
	fi
}
zle-line-init () {
	zle -K viins
	printf "\033[6 q"
}
zle -N zle-line-init
zle -N zle-keymap-select

# Enable colors.
autoload -U colors && colors

zstyle :compinstall filename '~/.zshrc'

# Interactive menu when selecting options using <Tab>.
zstyle ':completion:*' menu select
# Enable colors for menuselect.
zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}
# Press '+' within menuselect to add selected option and stay in menuselect.
bindkey -M menuselect "+" accept-and-menu-complete > /dev/null 2>&1

# Enable git information.
autoload -Uz vcs_info
zstyle ':vcs_info:git*' formats "%r/%S (%F{blue}%b%f)"
zstyle ':vcs_info:git*' actionformats "%r/%S (%F{blue}%b%f|%F{yellow}%a%f) %m%u%c"

# Some aliases.
alias ls="exa"
alias ll="exa -l"
alias la="exa -la"
alias l="exa"
alias c="cd"
alias s="sudo"
alias java-config="java-config -n"
alias ..="cd .." ...="cd ../.." ....="cd ../../.."
alias gpl="git pull"
alias gplo="gpl origin"
alias gplu="gpl upstream"
alias gph="git push"
alias gpho="gph origin"
alias gphu="gph upstream"
alias gd="git diff"
alias gdc="gd --cached"
alias gm="git merge"

precmd() {
	vcs_info

	if [[ ${vcs_info_msg_0_} ]]; then
		PS1="${vcs_info_msg_0_} %Bξ%b "
	else
		PS1="%~ %Bξ%b "
	fi

	RPS1="%(?..%B%F{red}%?%f%b)"
}

# Colors for fzf.
export FZF_DEFAULT_OPTS='
--color=bg+:\#073642,bg:\#002b36,spinner:\#719e07,hl:\#586e75
--color=fg:\#839496,header:\#586e75,info:\#cb4b16,pointer:\#719e07
--color=marker:\#719e07,fg+:\#839496,prompt:\#719e07,hl+:\#719e07
'

# Enable fzf if it exists.
[[ -n ~/.fzf.zsh ]] && source ~/.fzf.zsh 2> /dev/null || true

# Enable auto completion.
autoload -Uz compinit && compinit

# PATH
export PATH=$HOME/.gem/ruby/2.3.0/bin:$HOME/go/bin:$HOME/.local/usr/bin:$HOME/.local/bin:$PATH

# Fix git GPG signing
export GPG_TTY=$(tty)

# added by travis gem
[ -f /home/willeponken/.travis/travis.sh ] && source /home/willeponken/.travis/travis.sh
