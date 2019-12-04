#!/bin/sh
gcloud builds submit --async --substitutions=_LOCAL_PATH=/home/nui/.nmk/local,_DOCKER_TAG=ubuntu-18.04,_TAR_NAME=tmux-3.0a--nui--ubuntu-18.04
gcloud builds submit --async --substitutions=_LOCAL_PATH=/home/beid/.nmk/local,_DOCKER_TAG=ubuntu-18.04,_TAR_NAME=tmux-3.0a--beid--ubuntu-18.04
gcloud builds submit --async --substitutions=_LOCAL_PATH=/home/ubuntu/.nmk/local,_DOCKER_TAG=ubuntu-18.04,_TAR_NAME=tmux-3.0a--ubuntu--ubuntu-18.04
gcloud builds submit --async --substitutions=_LOCAL_PATH=/root/.nmk/local,_DOCKER_TAG=ubuntu-18.04,_TAR_NAME=tmux-3.0a--root--ubuntu-18.04

gcloud builds submit --async --substitutions=_LOCAL_PATH=/home/nui/.nmk/local,_DOCKER_TAG=centos-7.6.1810,_TAR_NAME=tmux-3.0a--nui--centos-7.6.1810
gcloud builds submit --async --substitutions=_LOCAL_PATH=/home/beid/.nmk/local,_DOCKER_TAG=centos-7.6.1810,_TAR_NAME=tmux-3.0a--beid--centos-7.6.1810
gcloud builds submit --async --substitutions=_LOCAL_PATH=/home/ubuntu/.nmk/local,_DOCKER_TAG=centos-7.6.1810,_TAR_NAME=tmux-3.0a--ubuntu--centos-7.6.1810
gcloud builds submit --async --substitutions=_LOCAL_PATH=/root/.nmk/local,_DOCKER_TAG=centos-7.6.1810,_TAR_NAME=tmux-3.0a--root--centos-7.6.1810

gcloud builds submit --async --substitutions=_LOCAL_PATH=/home/nui/.nmk/local,_DOCKER_TAG=centos-6.9,_TAR_NAME=tmux-3.0a--nui--centos-6.9
gcloud builds submit --async --substitutions=_LOCAL_PATH=/home/beid/.nmk/local,_DOCKER_TAG=centos-6.9,_TAR_NAME=tmux-3.0a--beid--centos-6.9
gcloud builds submit --async --substitutions=_LOCAL_PATH=/home/ubuntu/.nmk/local,_DOCKER_TAG=centos-6.9,_TAR_NAME=tmux-3.0a--ubuntu--centos-6.9
gcloud builds submit --async --substitutions=_LOCAL_PATH=/root/.nmk/local,_DOCKER_TAG=centos-6.9,_TAR_NAME=tmux-3.0a--root--centos-6.9
