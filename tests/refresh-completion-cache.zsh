#!/usr/bin/env zsh

set -u

test_dir="${TMPDIR:-/tmp}/lets-zsh-plugin-refresh-test.$$"
plugin_dir="${test_dir}/plugin"
fake_bin="${test_dir}/bin"

cleanup() {
    rm -rf "${test_dir}"
}
trap cleanup EXIT

fail() {
    print -ru2 -- "FAIL: $*"
    exit 1
}

assert_file_content() {
    local file="$1"
    local expected="$2"
    local actual

    actual="$(<"${file}")"
    [[ "${actual}" == "${expected}" ]] || fail "${file} content: expected ${expected:q}, got ${actual:q}"
}

assert_file_number() {
    local file="$1"
    local expected="$2"
    local actual

    actual="$(<"${file}")"
    [[ "${actual}" == "${expected}" ]] || fail "${file} value: expected ${expected}, got ${actual}"
}

mkdir -p "${plugin_dir}" "${fake_bin}"
cp "${0:A:h:h}/lets.plugin.zsh" "${plugin_dir}/lets.plugin.zsh"

write_fake_lets() {
    local version="$1"
    local completion="$2"
    local marker="$3"

    {
        print -r -- '#!/usr/bin/env zsh'
        print -r -- "# ${marker}"
        print -r -- 'case "$1" in'
        print -r -- '    --version)'
        print -r -- "        print -r -- ${(qqq)version}"
        print -r -- '        ;;'
        print -r -- '    completion)'
        print -r -- '        if [[ "$2" == "-s" && "$3" == "zsh" ]]; then'
        print -r -- '            if [[ -n "${LETS_FAKE_COMPLETION_COUNT_FILE:-}" ]]; then'
        print -r -- '                print -r -- $(( $(<"${LETS_FAKE_COMPLETION_COUNT_FILE}") + 1 )) >| "${LETS_FAKE_COMPLETION_COUNT_FILE}"'
        print -r -- '            fi'
        print -r -- "            print -r -- ${(qqq)completion}"
        print -r -- '        else'
        print -r -- '            exit 2'
        print -r -- '        fi'
        print -r -- '        ;;'
        print -r -- '    *)'
        print -r -- '        exit 2'
        print -r -- '        ;;'
        print -r -- 'esac'
    } > "${fake_bin}/lets"
    chmod +x "${fake_bin}/lets"
}

path=("${fake_bin}" ${path})
export LETS_FAKE_COMPLETION_COUNT_FILE="${test_dir}/completion-count"
print -r -- "0" > "${LETS_FAKE_COMPLETION_COUNT_FILE}"

write_fake_lets "lets version v1" "# completion v1" "first binary"
source "${plugin_dir}/lets.plugin.zsh"
assert_file_content "${plugin_dir}/_lets" "# completion v1"
assert_file_number "${LETS_FAKE_COMPLETION_COUNT_FILE}" 1

source "${plugin_dir}/lets.plugin.zsh"
assert_file_content "${plugin_dir}/_lets" "# completion v1"
assert_file_number "${LETS_FAKE_COMPLETION_COUNT_FILE}" 1

write_fake_lets "lets version v2" "# completion v2" "second binary"
source "${plugin_dir}/lets.plugin.zsh"
assert_file_content "${plugin_dir}/_lets" "# completion v2"
assert_file_number "${LETS_FAKE_COMPLETION_COUNT_FILE}" 2

write_fake_lets "lets version v2" "# completion v3" "same version replacement with different file size"
source "${plugin_dir}/lets.plugin.zsh"
assert_file_content "${plugin_dir}/_lets" "# completion v3"
assert_file_number "${LETS_FAKE_COMPLETION_COUNT_FILE}" 3
