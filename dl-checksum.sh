#!/usr/bin/env sh
set -e
DIR=~/Downloads
MIRROR=https://github.com

# https://github.com/prometheus/prometheus/releases/download/v2.11.1/prometheus-2.11.1.darwin-amd64.tar.gz
# https://github.com/prometheus/alertmanager/releases/download/v0.18.0/alertmanager-0.18.0.darwin-amd64.tar.gz

dl()
{
    local ghuser=$1
    local app=$2
    local ver=$3
    local os=$4
    local arch=$5
    local platform="${os}-${arch}"
    local file="${app}-${ver}.${platform}.tar.gz"
    local url="$MIRROR/$ghuser/$app/releases/download/v${ver}/$file"
    local lfile="$DIR/$file"

    if [ ! -e $lfile ];
    then
        wget -q -O $lfile $url
    fi

    printf "      # %s\n" $url
    printf "      %s-%s: sha256:%s\n" $os $arch `sha256sum $lfile | awk '{print $1}'`
}

dlapp()
{
    local ghuser=$1
    local app=$2
    local ver=$3
    printf "  %s:\n" $app
    printf "    '%s':\n" $ver
    for os in darwin linux windows
    do
        dl $ghuser $app $ver $os amd64
    done
}

dlapp prometheus prometheus 2.25.1
#dlapp prometheus alertmanager 0.21.0
#dlapp prometheus blackbox_exporter 0.18.0
#dlapp prometheus consul_exporter 0.7.1
#dlapp prometheus graphite_exporter 0.9.0
#dlapp prometheus haproxy_exporter 0.12.0
#dlapp prometheus memcached_exporter 0.8.0
#dlapp prometheus mysqld_exporter 0.12.1
dlapp prometheus node_exporter 1.1.2
dlapp prometheus pushgateway 1.4.0
dlapp prometheus statsd_exporter 0.20.0
dlapp prometheus-community bind_exporter 0.4.0
