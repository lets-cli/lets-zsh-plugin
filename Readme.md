# zsh autocompletion plugin for lets

Lets is a cli tool for developers that is a better alternative to make - https://github.com/lets-cli/lets

## Install as plugin

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

## Manual completions setup

You can set up completions manually (no plugins).

Usually to make completion works you have to make sure that:

1. A file with completions exists
2. A path to directory with a file with completions is in `$fpath` env.

`lets` can generate completions script for you

```bash
lets completion -s zsh
```
This will print completion script, and you have to save it somewhere, for example:

```bash
lets completion -s zsh ~/.my-completions/_lets
```

Now, add `~/.my-completions/_lets` to `fpath`

```bash
fpath=(~/.my-completions $fpath)
```

And just to be sure that everything will work as expected fine, rebuild `zcompdump`:

```bash
rm -f ~/.zcompdump; compinit
```

> Do not forget to add autoload call to the end of file (it actually can be after plugins section, but its better to add it to the end of `~/.zshrc`)

```shell script
autoload -U compinit && compinit
```

Restart terminal

```shell script
exec $SHELL -l
```

### Manual configuration for zinit

Since `zinit` adds `~/.local/share/zinit/completions` to `fpath`, you just need to put completions to that directory:

```sh
lets completion -s zsh > ~/.local/share/zinit/completions/_lets
```

### Manual configuration for oh-my-zsh

For `oh-my-zsh` these are usually one of the following directories in `fpath`:

- ~/.oh-my-zsh/completions
- ~/.zsh/completions 

```sh
lets completion -s zsh > ~/.oh-my-zsh/completions/_lets.zsh
```

### Configution
For zsh there is `--verbose` flag which generate completions with descriptions, like this:

```shell script
lets <tab>
... generated completions

build  -- Build my app
run    -- Run my app
test   -- Test my app
```

```bash
lets completion -s zsh --verbose
```