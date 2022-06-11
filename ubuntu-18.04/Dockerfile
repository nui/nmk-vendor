FROM ubuntu:18.04
ENV DOCKER_TAG=ubuntu-18.04

ARG USE_APT_CACHER="false"
ARG USE_APT_MIRROR="false"
ARG APT_CACHER_HOST="172.17.0.1"
ARG APT_MIRROR="th.archive.ubuntu.com"

RUN if [ "$USE_APT_MIRROR" = "true" ]; then sed -i "s|archive.ubuntu.com|$APT_MIRROR|g" /etc/apt/sources.list; fi \
    && if [ "$USE_APT_CACHER" = "true" ]; then echo "Acquire::http::Proxy \"http://$APT_CACHER_HOST:3142\";" > /etc/apt/apt.conf.d/11proxy; fi

RUN export DEBIAN_FRONTEND="noninteractive" \
    && apt-get -y update \
    && apt-get -y install apt-utils \
    && apt-get -y install autoconf build-essential curl libncurses-dev libssl-dev vim-nox zsh \
    # for silversearcher
    && apt-get -y install liblzma-dev libpcre3-dev pkg-config zlib1g-dev \
    # for build zsh documents
    && apt-get -y install yodl \
    # for htop
    && apt-get -y install libncursesw5-dev \
    && rm -rf /var/lib/apt/lists/*


ADD *.sha /build/
WORKDIR /build
ENV LIBEVENT_BUILD_DIR=libevent-2.1.12-stable \
    TMUX_BUILD_DIR=tmux-3.3a-1 \
    ZSH_BUILD_DIR=zsh-zsh-5.9 \
    HTOP_BUILD_DIR=htop-3.1.2

RUN curl -o libevent-2.1.12-stable.tar.gz -sSL "https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz" \
    && sha256sum -c libevent-2.1.12-stable.tar.gz.sha \
    && tar -xf libevent-2.1.12-stable.tar.gz \
    && rm libevent-2.1.12-stable.tar.gz libevent-2.1.12-stable.tar.gz.sha
RUN curl -o tmux-3.3a-1.tar.gz -sSL "https://github.com/nuimk/nmk-tmux/releases/download/3.3a-1/tmux-3.3a-1.tar.gz" \
    && sha256sum -c tmux-3.3a-1.tar.gz.sha \
    && tar -xf tmux-3.3a-1.tar.gz \
    && rm tmux-3.3a-1.tar.gz tmux-3.3a-1.tar.gz.sha
RUN curl -o zsh-5.9.tar.gz -sSL "https://github.com/zsh-users/zsh/archive/zsh-5.9.tar.gz" \
    && sha256sum -c zsh-5.9.tar.gz.sha \
    && tar -xf zsh-5.9.tar.gz \
    && rm zsh-5.9.tar.gz zsh-5.9.tar.gz.sha
RUN curl -o htop-3.1.2.tar.gz -sSL "https://github.com/htop-dev/htop/archive/refs/tags/3.1.2.tar.gz" \
    && sha256sum -c htop-3.1.2.tar.gz.sha \
    && tar -xf htop-3.1.2.tar.gz \
    && rm htop-3.1.2.tar.gz htop-3.1.2.tar.gz.sha

COPY entrypoint /
ENTRYPOINT ["/entrypoint"]
