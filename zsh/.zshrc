autoload -U colors && colors

git_branch() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return
  echo " (%F{green}$(git branch --show-current 2>/dev/null)%f)"
}

setopt PROMPT_SUBST
PROMPT='%{$fg[cyan]%}%n%{$reset_color%} %~$(git_branch) '

bindkey -v
# Function to change cursor style based on mode
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    # Command mode: block cursor (non-blinking)
    echo -ne "\e[2 q"
  else
    # Insert mode: blinking block cursor
    echo -ne "\e[1 q"
  fi
}

# Apply the cursor style when zsh starts
function zle-line-init {
  zle-keymap-select
}

zle -N zle-keymap-select
zle -N zle-line-init

export TERM=xterm-256color

source $(brew --prefix)/opt/fzf/shell/key-bindings.zsh
source $(brew --prefix)/opt/fzf/shell/completion.zsh

