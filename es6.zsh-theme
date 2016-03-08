local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
PROMPT='(%{$fg[magenta]%}%c%{$fg_bold[white]%}) %{$fg_bold[white]%}${ret_status}%{$fg_bold[white]%}%p($(git_prompt_info)) %{$fg_bold[white]%}${ret_status}%{$fg_bold[white]%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[white]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[white]%})"
