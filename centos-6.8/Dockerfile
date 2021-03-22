FROM centos:6.8
ENV DOCKER_TAG=centos-6.8

RUN true \
    && yum -y update \
    && yum -y groupinstall "Development Tools" \
    # for compile silversearcher
    && yum -y install pcre-devel xz-devel zlib-devel \
    && yum -y install file gcc kernel-devel make ncurses-devel tar sudo zsh \
    && yum clean all

RUN STAGING_DIR=$(mktemp -d) OUT_FILE=autoconf-2.69.tar.xz \
    && cd $STAGING_DIR \
    && curl -sSf -o $OUT_FILE http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.xz \
    && echo '64ebcec9f8ac5b2487125a86a7760d2591ac9e1d3dbd59489633f9de62a57684 *autoconf-2.69.tar.xz' > $OUT_FILE.sha \
    && sha256sum -c $OUT_FILE.sha \
    && tar -xf $OUT_FILE \
    && cd autoconf-2.69 && ./configure && make install \
    && rm -rf $STAGING_DIR


ADD *.sha /build/
WORKDIR /build
ENV LIBEVENT_BUILD_DIR=libevent-2.1.11-stable \
    TMUX_BUILD_DIR=tmux-3.1c-1 \
    ZSH_BUILD_DIR=zsh-zsh-5.8 \
    HTOP_BUILD_DIR=htop-3.0.5

RUN curl -o libevent-2.1.11-stable.tar.gz -sSL "https://github.com/libevent/libevent/releases/download/release-2.1.11-stable/libevent-2.1.11-stable.tar.gz" \
    && sha256sum -c libevent-2.1.11-stable.tar.gz.sha \
    && tar -xf libevent-2.1.11-stable.tar.gz \
    && rm libevent-2.1.11-stable.tar.gz libevent-2.1.11-stable.tar.gz.sha
RUN curl -o tmux-3.1c-1.tar.gz -sSL "https://github.com/nuimk/nmk-tmux/releases/download/3.1c-1/tmux-3.1c-1.tar.gz" \
    && sha256sum -c tmux-3.1c-1.tar.gz.sha \
    && tar -xf tmux-3.1c-1.tar.gz \
    && rm tmux-3.1c-1.tar.gz tmux-3.1c-1.tar.gz.sha
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
