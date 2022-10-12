# zsh autocompletion plugin for lets

Lets is a cli tool for developers that is a better alternative to make - https://github.com/lets-cli/lets

## Install

**oh-my-zsh**

Just clone plugin to oh-my-zsh plugins directory

```sh
cd ~/.oh-my-zsh/custom/plugins/
git clone https://github.com/lets-cli/lets-zsh-plugin.git lets
```

Open `~/.zshrc` and add `lets` to `plugins`

```shell script
 plugins=(lets)
```

**zinit**

Add to your `~/.zshrc`

```sh
zinit load lets-cli/lets-zsh-plugin
```

## Completions

To make completion work just generate completion script using `lets`

`lets completion -s <shell>`

For zsh there is `--verbose` flag which generate completions with descriptions, like this:

```shell script
lets <tab>
... generated completions

build  -- Build my app
run    -- Run my app
test   -- Test my app
```

You can put lets autocompletion in any folder existed in `$fpath`.

> You can add your custom folder with completions to $fpath by adding next line to your ~/.zshrc
>
> fpath=(~/.zsh/completion $fpath)
>
> It is required to modify fpath before `autoload -U compinit && compinit` line

**oh-my-zsh**

For `oh-my-zsh` this is usually one of the following:

- ~/.oh-my-zsh/completions
- ~/.zsh/completions 

```sh
lets completion -s zsh > ~/.oh-my-zsh/completions/_lets.zsh
```

**zinit**

```sh
lets completion -s zsh > ~/.local/share/zinit/completions/_lets
```

---

Do not forget to add autoload call to the end of file (it actually can be after plugins section, but its better to add it to the end of `~/.zshrc`)

```shell script
autoload -U compinit && compinit
```

Restart terminal

```shell script
exec $SHELL -l
```

