HISTFILE=~/.zsh-histfile
HISTSIZE=5000
SAVEHIST=5000
setopt append_history share_history histignorealldups autocd extendedglob
setopt nomatch notify correctall
unsetopt beep

# Third-party completions.
fpath=("$HOME/.zsh/completion" $fpath)

# Vi-mode
bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
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
alias ls="ls --color=auto"

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
[[ -n ~/.fzf.zsh ]] && source ~/.fzf.zsh

# Enable auto completion.
autoload -Uz compinit && compinit

# OPAM configuration
. $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
