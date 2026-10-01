# oh-my-zsh-theme-es6

Theme for Zsh based on ES6 arrow functions, with Git and Jujutsu support.

![](https://cldup.com/6OAAcYnG85.png)

## How to use

Copy the file `es6.zsh-theme` to your oh-my-zsh theme folder `~/.oh-my-zsh/themes`.

Or run in Terminal:

```sh
curl -o ~/.oh-my-zsh/themes/es6.zsh-theme https://raw.githubusercontent.com/suissa/oh-my-zsh-theme-es6/master/es6.zsh-theme
```

Set `ZSH_THEME="es6"` in your `~/.zshrc` file.

Restart your terminal or run: `source ~/.zshrc`.

### Jujutsu

When `jj` is installed and the current directory is a Jujutsu workspace (including a colocated Git repository), the prompt shows Jujutsu instead of Git:

```
(project) ➜ (jj:(tmqpnxto 5bb8e58e dockerizando) ✗) ➜
```

- The change ID, commit ID and first-line description identify the working-copy change.
- `✗` indicates uncommitted working-copy changes.
- The theme calls Jujutsu with `--ignore-working-copy`, so rendering the prompt does not snapshot or modify the workspace.
- Outside Jujutsu, the original Git prompt remains unchanged.

### Oh My Posh

Both `es6.zsh-theme.json` and `zsh-style.omp.json` now include the native `jujutsu` segment. It disables the Git segment in colocated repositories, avoiding duplicate source-control information.

Be happy.
