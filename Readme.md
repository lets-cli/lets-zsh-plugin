## Install

### Clone to oh-my-zsh custom plugins

1. Clone repo into your custom oh-my-zsh plugins

```sh
~/.oh-my-zsh/custom/plugins/
git clone lets
```

2. Open `~/.zshrc` and add `lets` to `plugins`
3. Restart terminal

### Add as custom completion

You can put lets autocompletion in any folder existed in `$fpath`.

This is usually one of the following:

- ~/.oh-my-zsh/completions
- ~/.zsh/completions 

1. Clone repo into anu folder you like.

```sh
git clone link...
```

2. Copy `lets` completion file to completions dir

```sh
cp lets.plugin.zsh ~/.oh-my-zsh/completions/_lets
```
3. Restart terminal