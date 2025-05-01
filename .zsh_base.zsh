# ░▀█▀░█▀▀░█▀▄░█▄█░▀█▀░█▀█░█▀█░█░░░░░█▀▀░█▄█░█░█░█░░░█▀█░▀█▀░█▀█░█▀▄
# ░░█░░█▀▀░█▀▄░█░█░░█░░█░█░█▀█░█░░░░░█▀▀░█░█░█░█░█░░░█▀█░░█░░█░█░█▀▄
# ░░▀░░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░░░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀░▀░░▀░░▀▀▀░▀░▀

# Get Terminal Emulator
TERM_EMULATOR=$(ps -h -o comm -p $PPID)

# ░█▀█░█▀▀░█▀█░█▀▀░█▀▀░▀█▀░█▀▀░█░█
# ░█░█░█▀▀░█░█░█▀▀░█▀▀░░█░░█░░░█▀█
# ░▀░▀░▀▀▀░▀▀▀░▀░░░▀▀▀░░▀░░▀▀▀░▀░▀

if [[ "$TERM_EMULATOR" == *"kitty"* ]];
then
	neofetch
	export TERM="xterm-kitty"
  alias view="kitty +kitten icat"
  alias ssh='kitten ssh'
	alias clear="kitty icat --clear && clear"

elif [[  "$TERM_EMULATOR" == *"tmux"*  ]] || [[ "$TERM_EMULATOR" == "login" ]];
	then
	export TERM="xterm-256color"
	neofetch --backend 'w3m'

elif [[ "$TERM" == *"xterm-ghostty"* ]];
  then
  export TERM="xterm-ghostty"
else
	export TERM="xterm-256color"
	neofetch --backend 'w3m'
fi

# ░▀▀█░█▀▀░█░█░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀
# ░▄▀░░▀▀█░█▀█░░░█░░░█░█░█░█░█▀▀░░█░░█░█
# ░▀▀▀░▀▀▀░▀░▀░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Improved less option
export LESS="--tabs=4 --no-init --LONG-PROMPT --ignore-case --RAW-CONTROL-CHARS"

# Watching other users
# WATCHFMT="%n %a %l from %m at %t."
watch=(notme)				# Report login/logout events for everybody except ourself.
# watch=(all)					# Report login/logout events for everybody except ourself.
LOGCHECK=60				# Time (seconds) between checks for login/logout activity.
REPORTTIME=5				# Display usage statistics for commands running > 5 sec.
# WORDCHARS="\"*?_-.[]~=/&;!#$%^(){}<>\""
# WORDCHARS="\"*?_-[]~&;!#$%^(){}<>\""
WORDCHARS='`~!@#$%^&*()-_=+[{]}\|;:",<.>/?'"'"

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt autocd							# Allow changing directories without `cd`
setopt append_history				# Dont overwrite history
setopt extended_history			# Also record time and duration of commands.
setopt share_history				# Share history between multiple shells
setopt hist_expire_dups_first	# Clear duplicates when trimming internal hist.
setopt hist_find_no_dups			# Dont display duplicates during searches.
setopt hist_ignore_dups			# Ignore consecutive duplicates.
setopt hist_ignore_all_dups		# Remember only one unique copy of the command.
setopt hist_reduce_blanks		# Remove superfluous blanks.
setopt hist_save_no_dups		# Omit older commands in favor of newer ones.

# Changing directories
#setopt auto_pushd					# Make cd push the old directory onto the directory stack.
setopt pushd_ignore_dups		# Dont push copies of the same dir on stack.
setopt pushd_minus				# Reference stack entries with "-".

setopt extended_glob				# Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation, etc. (An initial unquoted ‘~’ always produces named directory expansion.)
setopt -o vi

# ░█░░░█▀█░█▀▀░█▀█░█░░░█▀▀
# ░█░░░█░█░█░░░█▀█░█░░░█▀▀
# ░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀▀▀

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"


# ░█░█░█▀▀░█░█░█▀▄░▀█▀░█▀█░█▀▄░█▀▀
# ░█▀▄░█▀▀░░█░░█▀▄░░█░░█░█░█░█░▀▀█
# ░▀░▀░▀▀▀░░▀░░▀▀░░▀▀▀░▀░▀░▀▀░░▀▀▀

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"
export FZF_DEFAULT_COMMAND="rg --files"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --follow -E go -E Library -E Music"
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always {1}'"

bindkey -r emacs '\ec'
bindkey -r vicmd '\ec'
bindkey -r viins '\ec'

bindkey -M emacs '^k' fzf-cd-widget
bindkey -M vicmd '^k' fzf-cd-widget
bindkey -M viins '^k' fzf-cd-widget

# Fixes for alt-backspace and arrows keys
bindkey '^[^?' backward-kill-word

# ░█▀█░█░░░█░█░█▀▀░▀█▀░█▀█░█▀▀
# ░█▀▀░█░░░█░█░█░█░░█░░█░█░▀▀█
# ░▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀

# Check if zplug is installed
[ ! -d ~/.zplug ] && git clone https://github.com/zplug/zplug ~/.zplug
source ~/.zplug/init.zsh

# zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# zsh-users
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "plugins/archlinux", from:oh-my-zsh, if:"which pacman"

zplug "plugins/common-aliases", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh

# ░█▀▀░█▀█░█▄█░█▀█░█░░░█▀▀░▀█▀░▀█▀░█▀█░█▀█░█▀▀
# ░█░░░█░█░█░█░█▀▀░█░░░█▀▀░░█░░░█░░█░█░█░█░▀▀█
# ░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀

zstyle ':completion:*' rehash true
# zstyle ':completion:*' verbose yes
# zstyle ':completion:*:descriptions' format '%B%d%b'
# zstyle ':completion:*:messages' format '%d'
# zstyle ':completion:*:warnings' format 'No matches for: %d'
# zstyle ':completion:*' group-name ''

# Case-insensitive (all), partial-word and then substring completion
zstyle ":completion:*" matcher-list \
  "m:{a-zA-Z}={A-Za-z}" \
  "r:|[._-]=* r:|=*" \
  "l:|=* r:|=*"

zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS}

# Load SSH and GPG agents via keychain.
# /usr/bin/keychain -q $HOME/.ssh/id_rsa
# source $HOME/.keychain/osiris-sh
eval $(keychain --eval --quiet --noask)

# Install plugins if there are plugins that have not been installed
if ! zplug check; then
	printf "Install plugins? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# dircolors
if zplug check "seebi/dircolors-solarized"; then
	if which gdircolors &> /dev/null; then
		alias dircolors='() { $(whence -p gdircolors) }'
	fi
	if which dircolors &> /dev/null;
	then
		scheme="dircolors.ansi-universal"
		eval $(dircolors ~/.zplug/repos/seebi/dircolors-solarized/$scheme)
	fi
fi

# history
if zplug check "zsh-users/zsh-history-substring-search";
then
	zmodload zsh/terminfo
	bindkey "$terminfo[kcuu1]" history-substring-search-up
	bindkey "$terminfo[kcud1]" history-substring-search-down
	bindkey "^[[1;5A" history-substring-search-up
	bindkey "^[[1;5B" history-substring-search-down
fi

# ░█░█░█▀▀░█▀▀░█▀▄░░░█▀█░█░░░▀█▀░█▀█░█▀▀░█▀▀░█▀▀
# ░█░█░▀▀█░█▀▀░█▀▄░░░█▀█░█░░░░█░░█▀█░▀▀█░█▀▀░▀▀█
# ░▀▀▀░▀▀▀░▀▀▀░▀░▀░░░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀▀▀

[[ ! -f ~/.aliases.zsh ]] || source ~/.aliases.zsh

# ░█░█░█▀▀░█▀▀░█▀▄░░░█▀▀░█░█░█▀█░█▀█░█▀▄░▀█▀░█▀▀
# ░█░█░▀▀█░█▀▀░█▀▄░░░█▀▀░▄▀▄░█▀▀░█░█░█▀▄░░█░░▀▀█
# ░▀▀▀░▀▀▀░▀▀▀░▀░▀░░░▀▀▀░▀░▀░▀░░░▀▀▀░▀░▀░░▀░░▀▀▀

export VISUAL="nvim"
export EDITOR="$VISUAL"
export PINENTRY_PROGRAM="pinentry-rofi"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



# ░█▀█░█░░░▀█▀░█▀█░█▀▀
# ░█▀█░█░░░░█░░█▀█░▀▀█
# ░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀

# Generic command adaptations
alias grep='() { $(whence -p grep) --color=auto $@ }'
alias ls="eza --long --icons -F"
alias la="eza --long --icons -aF"
alias lst="eza --long --tree -aF -I node_modules\|.git --git-ignore"
alias lsta="eza --long --tree -aF"

alias dcu="docker compose up -d"
alias dc="docker compose"
alias dcd="docker compose down"
alias dcl="docker compose logs -f"
alias rm='rm -v'
alias wgup="wg-quick up wg0"

function load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

function automatically_activate_python_venv() {
  if [[ -z $VIRTUAL_ENV ]] ; then
    activate_venv
  else
    parentdir="$(dirname ${VIRTUAL_ENV})"
    if [[ "$PWD"/ != "$parentdir"/* ]] ; then
      deactivate
      activate_venv
    fi
  fi
}

function activate_venv() {  
  local d n
  d=$PWD
  
  until false 
  do 
  if [[ -f $d/.venv/bin/activate ]] ; then 
    source $d/.venv/bin/activate
    break
  fi
    d=${d%/*}
    # d="$(dirname "$d")"
    [[ $d = *\/* ]] || break
  done
}

zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

autoload -Uz add-zsh-hook 
add-zsh-hook precmd automatically_activate_python_venv
add-zsh-hook chpwd load-nvmrc

# ░█▀█░█▀█░█░█░█▀▀░█▀▄░█░░░█▀▀░█░█░█▀▀░█░░░▀█░░▄▀▄░█░█
# ░█▀▀░█░█░█▄█░█▀▀░█▀▄░█░░░█▀▀░▀▄▀░█▀▀░█░░░░█░░█ █░█▀▄
# ░▀░░░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀▀▀░░▀░░▀░▀

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

