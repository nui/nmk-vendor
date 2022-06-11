#!/bin/zsh
cd ${0:a:h}

centos_versions=(
    7.0.1406
    7.1.1503
    7.2.1511
    7.3.1611
    7.4.1708
    7.5.1804
    7.6.1810
    7.7.1908
    7.8.2003
    7.9.2009
    # 8
    # 8.1.1911
    # 8.2.2004
)

debian_versions=(8 9 10)

ubuntu_versions=(14.04 16.04 18.04 20.04 22.04)

echo_build() {
    distro=$1
    version=$2
    image=nmk-vendor:$distro-$version
    echo docker build --pull -t $image $distro-$version
    echo docker run -v $PWD/workspace:/workspace $image --name $distro-${version}_tmux-3.3a /nmk-vendor
    # echo docker rmi $image
}

for i in $centos_versions; do
    echo_build centos $i
done

for i in $debian_versions; do
    echo_build debian $i
done

for i in $ubuntu_versions; do
    echo_build ubuntu $i
done

for i in 1 2; do
    echo_build amazonlinux $i
done
