# zsh autocompletion plugin for lets

Lets is a cli tool for developers that is a better alternative to make - https://github.com/lets-cli/lets

## Install

### Add as a zsh plugin

#### Manual

1. Clone repo into your custom oh-my-zsh plugins

```sh
cd ~/.oh-my-zsh/custom/plugins/
git clone https://github.com/lets-cli/lets-zsh-plugin.git lets
cd lets
```

2. Install completions (you must choose between verbose and short version)

Verbose version - with description it looks like:

```shell script
lets <tab>
... generated completions

build  -- Build my app
run    -- Run my app
test   -- Test my app
```

```shell script
./install.sh --verbose
```

Short (concise) version - without description it looks like:

```shell script
lets <tab>
... generated completions

build run test
```

```shell script
./install.sh
```

3. Open `~/.zshrc` and add `lets` to `plugins`

```shell script
 plugins=(… lets)
```

Do not forget to add autoload call to the end of file (it actually can be after plugins section, but its better to add it to the end of `~/.zshrc`)

```shell script
autoload -U compinit && compinit
```

4. Restart terminal

```shell script
exec $SHELL -l
```

#### Antigen

```shell script
antigen bundle lets-cli/lets-zsh-plugin
```

### Add as custom completion

You can put lets autocompletion in any folder existed in `$fpath`.

This is usually one of the following:

- ~/.oh-my-zsh/completions
- ~/.zsh/completions 

> You can add your custom folder with completions to $fpath by adding next line to your ~/.zshrc
>
> fpath=(~/.zsh/completion $fpath)
>
> It is required to modify fpath before `autoload -U compinit && compinit` line

1. Generate `_lets.zsh` completion file

```shell script
lets completion -s zsh > ~/.oh-my-zsh/completions/_lets.zsh
```

**Verbose version of completion (see [above](#add-as-a-zsh-plugin))**

If you want a verbose completion (with description on the right side) - generate completion with `--verbose` flag

```shell script
lets completion -s zsh --verbose > ~/.oh-my-zsh/completions/_lets.zsh
```
