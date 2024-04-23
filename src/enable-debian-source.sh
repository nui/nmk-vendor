#!/bin/sh

# Enable source package
if [ -f /etc/apt/sources.list.d/debian.sources ]; then
    sed -i "s/Types: deb/Types: deb deb-src/g" /etc/apt/sources.list.d/debian.sources
elif [ -f /etc/apt/sources.list ]; then
    sed -i "s/^deb \(.*\)/deb \1\ndeb-src \1/g" /etc/apt/sources.list
fi
