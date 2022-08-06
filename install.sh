#!/bin/sh

# Vox Populi Linux installer

trap 'r=$?; echo "Installation failed!"; exit $r' EXIT

die() {
    fmt="$1"
    shift
    printf "$fmt\n" "$@" >&2
    exit 1
}

usage() {
    cat >&2 << EOF
usage: install.sh TYPE [CIV5DIR [DATADIR]]
Installs Vox Populi to Civ 5 located at CIV5DIR and user data at DATADIR. Old versions of Vox Populi, Community Patch, and EUI will be removed during installation.

TYPE       one of:
           - FullEUI: Vox Populi (with EUI)
           - FullNoEUI: Vox Populi (no EUI)
           - Core: Community Patch only
CIV5DIR    path to Civilization 5 (default: ~/.local/share/Steam/steamapps/common/Sid Meier's Civilization V)
DATADIR    path to user data (default: ~/.local/share/Aspyr/Sid Meier's Civilization 5)
EOF
}

verbose=
for arg; do
    case $arg in
        -v) verbose=-v ;;
        -*) usage; exit 1
    esac
done
if [ $# = 0 ] || [ $# -gt 3 ]; then
    usage
    exit 1
fi

instype=$1
civ5dir=$2
datadir=$3
case $instype in
    FullEUI|FullNoEUI|Core|43CivCPOnly|43CivNoEUI|43CivEUI) ;;
    *) die "invalid install type"
esac
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

copy() {
    rsync $verbose -rlptcW --delete --inplace "$@"
}

cat >&2 <<EOF
Vox Populi Installer for Linux

Install type: $instype
Civ 5 dir: $civ5dir
Data dir: $datadir

EOF

rm -rf "$datadir/cache"

set -- "(1) community patch" "(2) vox populi"

case $instype in
    Core) ;;
    *) set -- --exclude "(1) community patch/LUA" "$@";;
esac

case $instype in
    Core) rm -rf "$datadir/MODS/(2) vox populi" ;;
    *NoEUI) set -- "$@" "(2) vox populi" ;;
    *) set -- "$@" --exclude "(2) vox populi/LUA" "(2) vox populi" ;;
esac

case $instype in
    FullEUI) set -- "$@" "(3a) eui compatibility files" ;;
    *) rm -rf "$datadir/MODS/(3a) eui compatibility files" ;;
esac

case $instype in
    Core) rm -rf "$datadir/MODS/(4a) squads for vp" ;;
    *) set -- "$@" "(4a) squads for vp" ;;
esac

[ $# = 0 ] || copy "$@" "$datadir/MODS"

set --

case $instype in
    FullEUI) set -- "$@" "ui_bc1" ;;
    *) rm -rf "$civ5dir/steamassets/assets/dlc/ui_bc1" ;;
esac

case $instype in
    Core) rm -rf "$civ5dir/steamassets/assets/dlc/vpui" ;;
    *) set -- "$@" "vpui" ;;
esac

[ $# = 0 ] || copy "$@" "$civ5dir/steamassets/assets/dlc"

case $instype in
    Core) rm -f "$datadir/Text/vpui_tips_en_us.xml" ;;
    *) copy "vpui text/" "$datadir/Text/" ;;
esac

copy libCiv5XP_hook.so "$civ5dir"

cat >&2 << EOF
Installation complete. Change your launch options to:

    LD_PRELOAD=./libCiv5XP_hook.so %command%

Otherwise, the game will crash when loading DLL mods.
EOF

trap '' EXIT
