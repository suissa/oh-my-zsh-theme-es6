# Git JJ Flow

A Zsh and Oh My Posh theme with a compact arrow prompt for **Git** and **Jujutsu**.

![](https://cldup.com/6OAAcYnG85.png)

## Zsh / Oh My Zsh

Install the theme:

```sh
curl -Lo ~/.oh-my-zsh/themes/git-jj-flow.zsh-theme \
  https://raw.githubusercontent.com/suissa/oh-my-zsh-theme-es6/master/git-jj-flow.zsh-theme
```

Set this in `~/.zshrc`:

```sh
ZSH_THEME="git-jj-flow"
```

Restart the terminal or run `source ~/.zshrc`.

### Jujutsu behavior

When `jj` is installed and the directory is a Jujutsu workspace, including a colocated Git repository, Jujutsu takes precedence:

```
(project) ➜ (jj:(tmqpnxto 5bb8e58e dockerizando) ✗) ➜
```

- Shows the working-copy change ID, commit ID and description.
- `✗` means there are working-copy changes.
- Calls use `jj --ignore-working-copy`: rendering the prompt never snapshots or mutates the workspace.
- Outside a Jujutsu workspace, the regular Git prompt is used.

## Oh My Posh

Download the JSON configuration:

```sh
curl -Lo ~/.config/oh-my-posh/git-jj-flow.zsh-theme.json \
  https://raw.githubusercontent.com/suissa/oh-my-zsh-theme-es6/master/git-jj-flow.zsh-theme.json
```

It uses Oh My Posh's native `jujutsu` segment and disables Git in colocated repositories, so source-control information is never duplicated.

## Legacy filenames

`es6.zsh-theme`, `es6.zsh-theme.json` and `zsh-style.omp.json` remain available for compatibility. New installations should use `git-jj-flow`.

Be happy.
