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
- `✗` means there are working-copy changes; a clean working copy shows `✓` in green.
- Calls use `jj --ignore-working-copy`: rendering the prompt never snapshots or mutates the workspace.
- Outside a Jujutsu workspace, the regular Git prompt is used.

### Animations

The Zsh theme is animated without any external dependency:

- At startup it plays one short `· → ∙ → ➜` entrance.
- Each command return briefly pulses the prompt arrows: cyan after success, magenta after failure, then green/red.
- A `git add …` that runs longer than 450 ms shows a transient spinner while Git stages files. It is intentionally restricted to `git add`, which is normally silent; commands that write their own output are never animated.
- Once the repository is clean, the old `✗` position becomes a green `✓`.

Set `GIT_JJ_FLOW_ANIMATIONS=0` **before** Oh My Zsh is initialized to disable all motion.

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
