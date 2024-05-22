#!/bin/sh

# Enable source package and mirror
if [ -f /etc/apt/sources.list.d/ubuntu.sources ]; then
    sed -i "s/Types: deb/Types: deb deb-src/g" /etc/apt/sources.list.d/ubuntu.sources
    sed -i "s/archive.ubuntu.com/th.archive.ubuntu.com/g" /etc/apt/sources.list.d/ubuntu.sources
elif [ -f /etc/apt/sources.list ]; then
    sed -i "s/^deb \(.*\)/deb \1\ndeb-src \1/g" /etc/apt/sources.list
    sed -i "s/archive.ubuntu.com/th.archive.ubuntu.com/g" /etc/apt/sources.list
fi

