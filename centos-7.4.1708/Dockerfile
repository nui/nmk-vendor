FROM centos:7.4.1708
ENV _TAG=centos-7.4.1708

RUN true \
    && yum -y update \
    && yum -y groupinstall "Development Tools" \
    # for compile silversearcher
    && yum -y install pcre-devel xz-devel zlib-devel \
    && yum -y install file gcc kernel-devel make ncurses-devel tar sudo zsh \
    && yum clean all

ADD *.sha /build/
WORKDIR /build
ENV LIBEVENT_BUILD_DIR=libevent-2.1.8-stable \
    TMUX_BUILD_DIR=tmux-2.7 \
    AG_BUILD_DIR=the_silver_searcher-2.2.0 \
    ZSH_BUILD_DIR=zsh-zsh-5.5.1 \
    HTOP_BUILD_DIR=htop-2.2.0

RUN curl -o libevent-2.1.8-stable.tar.gz -sSL "https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz" \
    && sha256sum -c libevent-2.1.8-stable.tar.gz.sha \
    && tar -xf libevent-2.1.8-stable.tar.gz \
    && rm libevent-2.1.8-stable.tar.gz libevent-2.1.8-stable.tar.gz.sha
RUN curl -o tmux-2.7.tar.gz -sSL "https://github.com/nuimk/nmk-tmux/releases/download/2.7/tmux-2.7.tar.gz" \
    && sha256sum -c tmux-2.7.tar.gz.sha \
    && tar -xf tmux-2.7.tar.gz \
    && rm tmux-2.7.tar.gz tmux-2.7.tar.gz.sha
RUN curl -o zsh-5.5.1.tar.gz -sSL "https://github.com/zsh-users/zsh/archive/zsh-5.5.1.tar.gz" \
    && sha256sum -c zsh-5.5.1.tar.gz.sha \
    && tar -xf zsh-5.5.1.tar.gz \
    && rm zsh-5.5.1.tar.gz zsh-5.5.1.tar.gz.sha
RUN curl -o the_silver_searcher-2.2.0.tar.gz -sSL "http://geoff.greer.fm/ag/releases/the_silver_searcher-2.2.0.tar.gz" \
    && sha256sum -c the_silver_searcher-2.2.0.tar.gz.sha \
    && tar -xf the_silver_searcher-2.2.0.tar.gz \
    && rm the_silver_searcher-2.2.0.tar.gz the_silver_searcher-2.2.0.tar.gz.sha
RUN curl -o htop-2.2.0.tar.gz -sSL "https://github.com/hishamhm/htop/archive/2.2.0.tar.gz" \
    && sha256sum -c htop-2.2.0.tar.gz.sha \
    && tar -xf htop-2.2.0.tar.gz \
    && rm htop-2.2.0.tar.gz htop-2.2.0.tar.gz.sha

COPY entrypoint /
ENTRYPOINT ["/entrypoint"]
