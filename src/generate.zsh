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

local libevent_version=2.1.11
local htop_version=2.2.0

local tmux_tag=3.1b-1
local zsh_version=5.8

local tag=$distro-$version
local -a old_autoconf
old_autoconf=(centos-6.6 centos-6.7 centos-6.8 centos-6.9 centos-6.10)

local libevent_archive=libevent-${libevent_version}-stable.tar.gz
local tmux_archive=tmux-${tmux_tag}.tar.gz
local zsh_archive=zsh-${zsh_version}.tar.gz
local htop_archive=htop-${htop_version}.tar.gz

if [[ ${old_autoconf[(r)$tag]} == $tag ]]; then
cat << 'EOF'
RUN STAGING_DIR=$(mktemp -d) OUT_FILE=autoconf-2.69.tar.xz \
    && cd $STAGING_DIR \
    && curl -sSf -o $OUT_FILE http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.xz \
    && echo '64ebcec9f8ac5b2487125a86a7760d2591ac9e1d3dbd59489633f9de62a57684 *autoconf-2.69.tar.xz' > $OUT_FILE.sha \
    && sha256sum -c $OUT_FILE.sha \
    && tar -xf $OUT_FILE \
    && cd autoconf-2.69 && ./configure && make install \
    && rm -rf $STAGING_DIR

EOF
fi
cat << EOF

ADD *.sha /build/
WORKDIR /build
ENV LIBEVENT_BUILD_DIR=libevent-${libevent_version}-stable \\
    TMUX_BUILD_DIR=tmux-${tmux_tag} \\
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
debian_versions=(8 9)
for v in $debian_versions; do
    generate_context_dir debian $v
done

ubuntu_versions=(14.04 16.04 18.04 20.04)
for v in $ubuntu_versions; do
    generate_context_dir ubuntu $v
done

# don't add centos 5
centos_versions=(6.6 6.7 6.8 6.9 6.10 7.0.1406 7.1.1503 7.2.1511 7.3.1611 7.4.1708 7.5.1804 7.6.1810 7.7.1908 7.8.2003 8 8.1.1911 8.2.2004)
for v in $centos_versions; do
    generate_context_dir centos $v
done

amazonlinux_versions=(1 2)
for v in $amazonlinux_versions; do
    generate_context_dir amazonlinux $v
done

