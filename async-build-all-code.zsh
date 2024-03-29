#!/bin/zsh
# gcloud builds submit --async --substitutions=_DOCKER_TAG=ubuntu-18.04,_TAR_NAME=tmux-3.1b--ubuntu-18.04

TAGS=(
    amazonlinux-1
    amazonlinux-2
    centos-7.0.1406
    centos-7.6.1810
    centos-7.7.1908
    centos-7.8.2003
    centos-7.9.2009
    centos-8.1.1911
    centos-8.2.2004
    debian-8
    debian-9
    debian-10
    ubuntu-14.04
    ubuntu-16.04
    ubuntu-18.04
    ubuntu-20.04
    ubuntu-22.04
)

for tag in $TAGS; do
    echo gcloud builds submit --async --substitutions="_DOCKER_TAG=$tag,_TAR_NAME=${tag}_tmux-3.1c"
done
