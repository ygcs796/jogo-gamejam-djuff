#!/bin/sh
printf '\033c\033]0;%s\a' jogo-gamejam-djuff
base_path="$(dirname "$(realpath "$0")")"
"$base_path/shift.x86_64" "$@"
