# Git remains the fallback. In a Jujutsu workspace, Jujutsu is authoritative.
es6_jj_prompt_info() {
  (( $+commands[jj] )) || return 1
  command jj --ignore-working-copy root >/dev/null 2>&1 || return 1

  local change diff_summary
  change="$(command jj --ignore-working-copy log -r @ --no-graph -T 'change_id.short(8) ++ " " ++ commit_id.short(8) ++ " " ++ description.first_line()' 2>/dev/null)" || return 1
  diff_summary="$(command jj --ignore-working-copy diff --summary 2>/dev/null)"

  print -n "%{$fg_bold[white]%}(jj:(%{$fg[cyan]%}${change}%{$fg_bold[white]%})"
  [[ -n "$diff_summary" ]] && print -n " %{$fg[yellow]%}✗"
  print -n "%{$reset_color%}"
}

es6_vcs_prompt_info() {
  es6_jj_prompt_info || git_prompt_info
}

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
PROMPT='(%{$fg[magenta]%}%c%{$fg_bold[white]%}) %{$fg_bold[white]%}${ret_status}%{$fg_bold[white]%}%p($(es6_vcs_prompt_info)) %{$fg_bold[white]%}${ret_status}%{$fg_bold[white]%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[white]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[white]%})"
