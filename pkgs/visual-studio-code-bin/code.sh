#!/bin/bash

set -euo pipefail

flags_file="${XDG_CONFIG_HOME:-$HOME/.config}/code-flags.conf"

declare -a codeflags

if [[ -f "${flags_file}" ]]; then
    mapfile -t < "${flags_file}"
fi

for line in "${MAPFILE[@]}"; do
    if [[ ! "${line}" =~ ^[[:space:]]*#.* ]]; then
        codeflags+=("${line}")
    fi
done

exec /opt/visual-studio-code/bin/code "$@" "${codeflags[@]}"