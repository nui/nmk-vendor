#!/bin/zsh
cd ${0:A:h}

function print_remove_systemd {
cat <<- EOU
# Workaround for centos 7.0, 7.1
RUN yum -y remove systemd
EOU
}

fix_centos_dependency_conflict() {
    local version=$1
    local -a bug_versions
    bug_versions=(7.0.1406 7.1.1503)
    [[ ${bug_versions[(r)$version]} == $version ]] && {
        print_remove_systemd
    }
}

build_context() {
local distro=$1
local version=$2

local ag_version=2.2.0
local libevent_version=2.1.11
local htop_version=2.2.0

local tmux_tag=3.0-1
local zsh_version

local tag=$distro-$version
local -a old_autoconf
old_autoconf=(centos-6.6 centos-6.7 centos-6.8 centos-6.9 centos-6.10)
if [[ ${old_autoconf[(r)$tag]} == $tag ]]; then
    zsh_version=5.5.1
else
    zsh_version=5.7.1
fi


local ag_archive=the_silver_searcher-${ag_version}.tar.gz
local libevent_archive=libevent-${libevent_version}-stable.tar.gz
local tmux_archive=tmux-${tmux_tag}.tar.gz
local zsh_archive=zsh-${zsh_version}.tar.gz
local htop_archive=htop-${htop_version}.tar.gz
cat << EOF
ADD *.sha /build/
WORKDIR /build
ENV LIBEVENT_BUILD_DIR=libevent-${libevent_version}-stable \\
    TMUX_BUILD_DIR=tmux-${tmux_tag} \\
    AG_BUILD_DIR=the_silver_searcher-${ag_version} \\
    ZSH_BUILD_DIR=zsh-zsh-${zsh_version} \\
    HTOP_BUILD_DIR=htop-${htop_version}

RUN curl -o ${libevent_archive} -sSL "https://github.com/libevent/libevent/releases/download/release-${libevent_version}-stable/${libevent_archive}" \\
    && sha256sum -c ${libevent_archive}.sha \\
    && tar -xf ${libevent_archive} \\
    && rm ${libevent_archive} ${libevent_archive}.sha
RUN curl -o ${tmux_archive} -sSL "https://github.com/nuimk/nmk-tmux/releases/download/${tmux_tag}/${tmux_archive}" \\
    && sha256sum -c ${tmux_archive}.sha \\
    && tar -xf ${tmux_archive} \\
    && rm ${tmux_archive} ${tmux_archive}.sha
RUN curl -o ${zsh_archive} -sSL "https://github.com/zsh-users/zsh/archive/${zsh_archive}" \\
    && sha256sum -c ${zsh_archive}.sha \\
    && tar -xf ${zsh_archive} \\
    && rm ${zsh_archive} ${zsh_archive}.sha
RUN curl -o ${ag_archive} -sSL "http://geoff.greer.fm/ag/releases/${ag_archive}" \\
    && sha256sum -c ${ag_archive}.sha \\
    && tar -xf ${ag_archive} \\
    && rm ${ag_archive} ${ag_archive}.sha
RUN curl -o ${htop_archive} -sSL "https://github.com/hishamhm/htop/archive/${htop_version}.tar.gz" \\
    && sha256sum -c ${htop_archive}.sha \\
    && tar -xf ${htop_archive} \\
    && rm ${htop_archive} ${htop_archive}.sha

COPY entrypoint /
ENTRYPOINT ["/entrypoint"]
EOF
}

generate_context_dir() {
    local distro=$1
    local version=$2
    local target=../$distro-$version
    local dockerfile=$target/Dockerfile
    rm -rf $target
    mkdir $target
    print "FROM $distro:$version" > $dockerfile
    print "ENV DOCKER_TAG=${distro}-${version}\n" >> $dockerfile
    [[ $distro == centos ]] && fix_centos_dependency_conflict $version >> $dockerfile
    <Dockerfile.$distro >> $dockerfile
    build_context $distro $version >> $dockerfile
    cp entrypoint *.sha $target
}
debian_versions=(7 8 9)
for v in $debian_versions; do
    generate_context_dir debian $v
done

ubuntu_versions=(14.04 16.04 18.04)
for v in $ubuntu_versions; do
    generate_context_dir ubuntu $v
done

# don't add centos 5
centos_versions=(6.6 6.7 6.8 6.9 6.10 7.0.1406 7.1.1503 7.2.1511 7.3.1611 7.4.1708 7.5.1804 7.6.1810)
for v in $centos_versions; do
    generate_context_dir centos $v
done

