# Autocompletion for lets.
#
# According to the Zsh Plugin Standard:
# https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html

0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# add plugin directory to fpath
fpath+="${0:A:h}"
PLUGIN_BIN="${0:A:h}"

_lets_zsh_plugin_refresh_completion() {
    emulate -L zsh

    local plugin_bin="$1"
    local lets_executable="${LETS_EXECUTABLE:-lets}"
    local lets_resolved_path lets_version lets_file_signature current_signature saved_signature
    local -A lets_stat
    local completion_file="${plugin_bin}/_lets"
    local signature_file="${plugin_bin}/.lets-completion-signature"
    local completion_tmp="${completion_file}.$$.tmp"
    local signature_tmp="${signature_file}.$$.tmp"

    lets_resolved_path="$(command -v -- "${lets_executable}" 2>/dev/null)" || return 0
    lets_version="$("${lets_executable}" --version 2>/dev/null)" || lets_version=""
    if zmodload -F zsh/stat b:zstat 2>/dev/null &&
        zstat -H lets_stat -- "${lets_resolved_path}" 2>/dev/null; then
        lets_file_signature="${lets_stat[mtime]} ${lets_stat[size]}"
    fi
    current_signature="${lets_resolved_path}"$'\n'"${lets_version}"$'\n'"${lets_file_signature}"

    if [[ -f "${signature_file}" ]]; then
        saved_signature="$(<"${signature_file}")"
    fi

    if [[ -f "${completion_file}" && "${saved_signature}" == "${current_signature}" ]]; then
        return 0
    fi

    if "${lets_executable}" completion -s zsh >| "${completion_tmp}"; then
        {
            print -r -- "${lets_resolved_path}"
            print -r -- "${lets_version}"
            print -r -- "${lets_file_signature}"
        } >| "${signature_tmp}"
        if mv -f -- "${completion_tmp}" "${completion_file}" &&
            mv -f -- "${signature_tmp}" "${signature_file}"; then
            unfunction _lets 2>/dev/null || true
        else
            rm -f -- "${completion_tmp}" "${signature_tmp}"
        fi
    else
        rm -f -- "${completion_tmp}" "${signature_tmp}"
    fi
}

_lets_zsh_plugin_refresh_completion "${PLUGIN_BIN}"
unfunction _lets_zsh_plugin_refresh_completion
