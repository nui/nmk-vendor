FROM centos:7.9.2009
ENV DOCKER_TAG=centos-7.9.2009

RUN true \
    && yum -y update \
    && yum -y groupinstall "Development Tools" \
    # for compile silversearcher
    && yum -y install pcre-devel xz-devel zlib-devel \
    && yum -y install file gcc kernel-devel make ncurses-devel tar sudo zsh \
    && yum clean all


ADD *.sha /build/
WORKDIR /build
ENV LIBEVENT_BUILD_DIR=libevent-2.1.11-stable \
    TMUX_BUILD_DIR=tmux-3.2a-1 \
    ZSH_BUILD_DIR=zsh-zsh-5.8 \
    HTOP_BUILD_DIR=htop-3.0.5

RUN curl -o libevent-2.1.11-stable.tar.gz -sSL "https://github.com/libevent/libevent/releases/download/release-2.1.11-stable/libevent-2.1.11-stable.tar.gz" \
    && sha256sum -c libevent-2.1.11-stable.tar.gz.sha \
    && tar -xf libevent-2.1.11-stable.tar.gz \
    && rm libevent-2.1.11-stable.tar.gz libevent-2.1.11-stable.tar.gz.sha
RUN curl -o tmux-3.2a-1.tar.gz -sSL "https://github.com/nuimk/nmk-tmux/releases/download/3.2a-1/tmux-3.2a-1.tar.gz" \
    && sha256sum -c tmux-3.2a-1.tar.gz.sha \
    && tar -xf tmux-3.2a-1.tar.gz \
    && rm tmux-3.2a-1.tar.gz tmux-3.2a-1.tar.gz.sha
RUN curl -o zsh-5.8.tar.gz -sSL "https://github.com/zsh-users/zsh/archive/zsh-5.8.tar.gz" \
    && sha256sum -c zsh-5.8.tar.gz.sha \
    && tar -xf zsh-5.8.tar.gz \
    && rm zsh-5.8.tar.gz zsh-5.8.tar.gz.sha
RUN curl -o htop-3.0.5.tar.gz -sSL "https://github.com/htop-dev/htop/archive/3.0.5.tar.gz" \
    && sha256sum -c htop-3.0.5.tar.gz.sha \
    && tar -xf htop-3.0.5.tar.gz \
    && rm htop-3.0.5.tar.gz htop-3.0.5.tar.gz.sha

COPY entrypoint /
ENTRYPOINT ["/entrypoint"]
