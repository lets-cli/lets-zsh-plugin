# Autocompletion for lets.
#
# According to the Zsh Plugin Standard:
# https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html

0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# add plugin directory to fpath
fpath+="${0:A:h}"
PLUGIN_BIN="$(dirname $0)"

# init completions script if not already done
if [[ ! -f "${PLUGIN_BIN}/_lets" ]]; then
    lets completion -s zsh > "${PLUGIN_BIN}/_lets"
fi
