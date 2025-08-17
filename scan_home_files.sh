#!/bin/bash

# Description:
#   Scans all user home directories under /home for files with specified extensions.
#   If no extensions are specified, all files are listed.

# Usage examples:
#   ./scan_home_files.sh           # List all files
#   ./scan_home_files.sh txt       # List only .txt files
#   ./scan_home_files.sh jpg png   # List .jpg and .png files

base_dir="/home"
find_cmd=(find "$base_dir" -type f)

# If extensions are provided
if [ "$#" -gt 0 ]; then
    ext_expr=()
    for ext in "$@"; do
        ext="${ext,,}"
        ext_expr+=(-iname "*.${ext}" -o)
    done
    unset 'ext_expr[${#ext_expr[@]}-1]'

    find_cmd+=("(" "${ext_expr[@]}" ")")
fi

"${find_cmd[@]}"
