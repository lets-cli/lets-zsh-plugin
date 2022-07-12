# Autocompletion for lets.

# According to the standard:
# https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# Load the plugin itself to fpath
if [[ ${zsh_loaded_plugins[-1]} != */lets && -z ${fpath[(r)${0:h}]} ]]
then
  fpath+=( "${0:h}" )
fi

if [[ ! -f _lets ]]; then
    lets completion -s zsh --verbose > _lets
fi
