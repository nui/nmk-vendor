#!/bin/sh
gcloud builds submit --async --substitutions=_LOCAL_PATH=/home/nui/.nmk/local,_DOCKER_TAG=ubuntu-18.04,_TAR_NAME=tmux-3.0--nui--ubuntu-18.04
gcloud builds submit --async --substitutions=_LOCAL_PATH=/home/beid/.nmk/local,_DOCKER_TAG=ubuntu-18.04,_TAR_NAME=tmux-3.0--beid--ubuntu-18.04
gcloud builds submit --async --substitutions=_LOCAL_PATH=/home/ubuntu/.nmk/local,_DOCKER_TAG=ubuntu-18.04,_TAR_NAME=tmux-3.0--ubuntu--ubuntu-18.04
gcloud builds submit --async --substitutions=_LOCAL_PATH=/root/.nmk/local,_DOCKER_TAG=ubuntu-18.04,_TAR_NAME=tmux-3.0--root--ubuntu-18.04

gcloud builds submit --async --substitutions=_LOCAL_PATH=/home/nui/.nmk/local,_DOCKER_TAG=centos-7.6.1810,_TAR_NAME=tmux-3.0--nui--centos-7.6.1810
gcloud builds submit --async --substitutions=_LOCAL_PATH=/home/beid/.nmk/local,_DOCKER_TAG=centos-7.6.1810,_TAR_NAME=tmux-3.0--beid--centos-7.6.1810
gcloud builds submit --async --substitutions=_LOCAL_PATH=/home/ubuntu/.nmk/local,_DOCKER_TAG=centos-7.6.1810,_TAR_NAME=tmux-3.0--ubuntu--centos-7.6.1810
gcloud builds submit --async --substitutions=_LOCAL_PATH=/root/.nmk/local,_DOCKER_TAG=centos-7.6.1810,_TAR_NAME=tmux-3.0--root--centos-7.6.1810

gcloud builds submit --async --substitutions=_LOCAL_PATH=/home/nui/.nmk/local,_DOCKER_TAG=centos-6.9,_TAR_NAME=tmux-2.9a--nui--centos-6.9
gcloud builds submit --async --substitutions=_LOCAL_PATH=/home/beid/.nmk/local,_DOCKER_TAG=centos-6.9,_TAR_NAME=tmux-2.9a--beid--centos-6.9
gcloud builds submit --async --substitutions=_LOCAL_PATH=/home/ubuntu/.nmk/local,_DOCKER_TAG=centos-6.9,_TAR_NAME=tmux-2.9a--ubuntu--centos-6.9
gcloud builds submit --async --substitutions=_LOCAL_PATH=/root/.nmk/local,_DOCKER_TAG=centos-6.9,_TAR_NAME=tmux-2.9a--root--centos-6.9
