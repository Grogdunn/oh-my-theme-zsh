# ZSH Theme - Preview: https://cl.ly/f701d00760f8059e06dc
# Thanks to gallifrey, upon whose theme this is based

local return_code="%(?.⚙.%{$fg_bold[red]%}%? ⚠%{$reset_color%})"

function my_git_prompt_info() {
  ! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return

  ref=${$(git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD)#(refs/heads/|tags/)}
  GIT_STATUS=$(git_prompt_status)
  color="green"
  [[ -n $GIT_STATUS ]] && color="yellow"
  [[ -n $GIT_STATUS ]] && GIT_STATUS=" $GIT_STATUS"
  echo "%{$fg[$color]%}$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$GIT_STATUS%{$fg[$color]%}$ZSH_THEME_GIT_PROMPT_SUFFIX%{$reset_color%}"
}

function hostnameColor(){
  if [ -z "${HOSTNAME_COLOR}" ]; then    
    local MIN_COLOR=110
    local MAX_COLOR=229
    HASH=$(echo "${HOSTNAME}"|md5sum | cut --characters=1-8)
    export HOSTNAME_COLOR=$(echo -en $(( 16#${HASH} % (${MAX_COLOR} - ${MIN_COLOR}) + ${MIN_COLOR} )))
  fi
  echo "%{$FX[bold]$FG[$HOSTNAME_COLOR]%}"
}

PROMPT='$(hostnameColor)%n@%m%{$reset_color%}:%{$fg_bold[blue]%}%~%{$reset_color%} $(my_git_prompt_info)%{$reset_color%}%B${return_code} %{$fg_bold[green]%}$%{$reset_color%}%b '
#PROMPT='%{$fg_bold[green]%}%n@%m%{$reset_color%}:%{$fg_bold[blue]%}%~%{$reset_color%} $(my_git_prompt_info)%{$reset_color%}%B${return_code} %{$fg_bold[green]%}$%{$reset_color%}%b '
#RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="◖"
ZSH_THEME_GIT_PROMPT_SUFFIX="◗"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[blue]%}%%%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}+%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[cyan]%}~%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}!%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[grey]%}?%{$reset_color%}"

