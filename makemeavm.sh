#!/bin/bash

# makemeavm.sh 1.0
#
# Creates VMs for Parallels Desktop on Apple Silicon using Apple's .ipsw files

if [ -z $1 ] ; then
    echo "USAGE: makemeavm.sh <path to .ipsw file>"
    exit 1
fi

version=$(echo ${1} | awk -F"_" '{ print $2 }')

echo "macOS $version detected"

if [ -e ~/Parallels/macOS-$version.macvm ] ; then
    echo "ERROR: macOS-$version.macvm already exists!"
fi

/Applications/Parallels\ Desktop.app/Contents/MacOS/prl_macvm_create $1 ~/Parallels/macOS-$version.macvm --disksize 64000000000

cat <<EOF > ~/Parallels/macOS-$version.macvm/config.ini
[Hardware]
vCPU.Count=4
Memory.Size=4294967296
Display.Width=1024
Display.Height=768
Display.DPI=72
Sound.Enabled=1
Network.Type=2
EOF

exit 0
