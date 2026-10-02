# Git remains the fallback. In a Jujutsu workspace, Jujutsu is authoritative.
autoload -Uz add-zsh-hook add-zle-hook-widget

typeset -g GIT_JJ_FLOW_LAST_STATUS=0
typeset -g GIT_JJ_FLOW_PULSE=0
typeset -g GIT_JJ_FLOW_SPINNER_PID=""

git_jj_flow_entry_animation() {
  [[ -o interactive && ${GIT_JJ_FLOW_ANIMATIONS:-1} != 0 && -z ${GIT_JJ_FLOW_ENTRY_SHOWN:-} ]] || return

  typeset -gx GIT_JJ_FLOW_ENTRY_SHOWN=1
  local frame
  for frame in "·" "∙" "➜"; do
    print -n "\r%{$fg[cyan]%}${frame}%{$reset_color%}"
    command sleep 0.05
  done
  print -n $'\r\e[2K'
}

git_jj_flow_record_status() {
  GIT_JJ_FLOW_LAST_STATUS=$?
  GIT_JJ_FLOW_PULSE=1
}

git_jj_flow_status_arrow() {
  local color
  if (( GIT_JJ_FLOW_LAST_STATUS == 0 )); then
    color=${GIT_JJ_FLOW_PULSE:+$fg_bold[cyan]}
    [[ -n "${color}" ]] || color=$fg_bold[green]
  else
    color=${GIT_JJ_FLOW_PULSE:+$fg_bold[magenta]}
    [[ -n "${color}" ]] || color=$fg_bold[red]
  fi
  print -n "%{${color}%}➜%{$reset_color%}"
}

git_jj_flow_pulse_arrow() {
  (( GIT_JJ_FLOW_PULSE && ${GIT_JJ_FLOW_ANIMATIONS:-1} != 0 )) || return
  zle -R
  command sleep 0.08
  GIT_JJ_FLOW_PULSE=0
  zle reset-prompt
}

git_jj_flow_start_staging_spinner() {
  [[ ${GIT_JJ_FLOW_ANIMATIONS:-1} != 0 && -t 1 && -w /dev/tty ]] || return

  (
    command sleep 0.45
    local -a frames=("◜" "◠" "◝" "◞" "◡" "◟")
    local frame
    while true; do
      for frame in "${frames[@]}"; do
        printf '\r\033[2K\033[36m%s staging changes…\033[0m' "${frame}" > /dev/tty
        command sleep 0.10
      done
    done
  ) &
  GIT_JJ_FLOW_SPINNER_PID=$!
}

git_jj_flow_stop_staging_spinner() {
  [[ -n "${GIT_JJ_FLOW_SPINNER_PID}" ]] || return
  kill "${GIT_JJ_FLOW_SPINNER_PID}" 2>/dev/null
  wait "${GIT_JJ_FLOW_SPINNER_PID}" 2>/dev/null
  GIT_JJ_FLOW_SPINNER_PID=""
  [[ -w /dev/tty ]] && printf '\r\033[2K' > /dev/tty
}

# Git is wrapped only to animate a silent, long-running "git add".
git() {
  if [[ "$1" == "add" ]]; then
    git_jj_flow_start_staging_spinner
    command git "$@"
    local status=$?
    git_jj_flow_stop_staging_spinner
    return $status
  fi
  command git "$@"
}

git_jj_flow_jj_prompt_info() {
  (( $+commands[jj] )) || return 1
  command jj --ignore-working-copy root >/dev/null 2>&1 || return 1

  local change diff_summary
  change="$(command jj --ignore-working-copy log -r @ --no-graph -T 'change_id.short(8) ++ " " ++ commit_id.short(8) ++ " " ++ description.first_line()' 2>/dev/null)" || return 1
  diff_summary="$(command jj --ignore-working-copy diff --summary 2>/dev/null)"

  print -n "%{$fg_bold[white]%}(jj:(%{$fg[cyan]%}${change}%{$fg_bold[white]%})"
  if [[ -n "$diff_summary" ]]; then
    print -n " %{$fg[yellow]%}✗"
  else
    print -n " %{$fg[green]%}✓"
  fi
  print -n "%{$reset_color%}"
}

git_jj_flow_vcs_prompt_info() {
  git_jj_flow_jj_prompt_info || git_prompt_info
}

if [[ -o interactive ]]; then
  add-zsh-hook precmd git_jj_flow_record_status
  add-zle-hook-widget line-init git_jj_flow_pulse_arrow
  git_jj_flow_entry_animation
fi

PROMPT='(%{$fg[magenta]%}%c%{$fg_bold[white]%}) $(git_jj_flow_status_arrow) %{$fg_bold[white]%}%p($(git_jj_flow_vcs_prompt_info)) $(git_jj_flow_status_arrow) '

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[white]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[white]%}) %{$fg[green]%}✓%{$reset_color%}"
