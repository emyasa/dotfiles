autoload -U colors && colors

git_branch() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return
  echo " (%F{green}$(git branch --show-current 2>/dev/null)%f)"
}

setopt PROMPT_SUBST
PROMPT='%{$fg[cyan]%}%n%{$reset_color%} %~$(git_branch) '

