#!/bin/sh

# Vox Populi Linux uninstaller

set -e

die() {
    fmt="$1"
    shift
    printf "$fmt\n" "$@" >&2
    exit 1
}

usage() {
    cat >&2 << EOF
usage: uninstall.sh [CIV5DIR [DATADIR]]

CIV5DIR    path to Civilization 5 (default: ~/.local/share/Steam/steamapps/common/Sid Meier's Civilization V)
DATADIR    path to user data (default: ~/.local/share/Aspyr/Sid Meier's Civilization 5)
EOF
}

for arg; do
    case $arg in
        -*) usage; exit 1
    esac
done
if [ $# = 0 ] || [ $# -gt 2 ]; then
    usage
    exit 1
fi

civ5dir=$1
datadir=$2
if [ -z "$civ5dir" ]; then
    civ5dir="$HOME/.local/share/Steam/steamapps/common/Sid Meier's Civilization V"
    [ -d "$civ5dir" ] || die "could not auto-detect Civ 5 directory"
else
    [ -d "$civ5dir" ] || die "Civ 5 directory does not exist"
fi
if [ -z "$datadir" ]; then
    datadir="$HOME/.local/share/Aspyr/Sid Meier's Civilization 5"
    [ -d "$datadir" ] || die "could not auto-detect mods directory"
else
    [ -d "$datadir" ] || die "mods directory does not exist"
fi

printf '%s\n' "Uninstalling Vox Populi, Community Patch, and EUI from \"$civ5dir\" and \"$datadir\"..." >&2

rm -rf "$datadir/cache" "$datadir/MODS/(1) community patch" "$datadir/MODS/(2) vox populi" "$datadir/MODS/(3a) eui compatibility files" "$datadir/MODS/(4a) promotion icons for vp" "$datadir/MODS/(4b) ui - promotion tree for vp" "$civ5dir/steamassets/assets/dlc/ui_bc1" "$civ5dir/steamassets/assets/dlc/vpui" "$civ5dir/libCiv5XP_hook.so"

echo Done! >&2
