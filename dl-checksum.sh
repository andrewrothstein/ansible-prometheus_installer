#!/usr/bin/env sh
DIR=~/Downloads
MIRROR=https://github.com/prometheus

# https://github.com/prometheus/prometheus/releases/download/v2.11.1/prometheus-2.11.1.darwin-amd64.tar.gz
# https://github.com/prometheus/alertmanager/releases/download/v0.18.0/alertmanager-0.18.0.darwin-amd64.tar.gz

dl()
{
    local app=$1
    local ver=$2
    local os=$3
    local arch=$4
    local file=${app}-${ver}.${os}-${arch}.tar.gz
    local url=$MIRROR/$app/releases/download/v${ver}/$file
    local lfile=$DIR/$file

    if [ ! -e $lfile ];
    then
        wget -q -O $lfile $url
    fi

    printf "      # %s\n" $url
    printf "      %s-%s: sha256:%s\n" $os $arch `sha256sum $lfile | awk '{print $1}'`
}

dlapp()
{
    local app=$1
    local ver=$2
    printf "  %s:\n" $app
    printf "    '%s':\n" $ver
    for os in darwin linux windows
    do
        dl $app $ver $os amd64
    done
}

dlapp prometheus 2.23.0
#dlapp alertmanager 0.21.0
#dlapp blackbox_exporter 0.18.0
#dlapp consul_exporter 0.7.1
#dlapp graphite_exporter 0.9.0
#dlapp haproxy_exporter 0.11.0
#dlapp memcached_exporter 0.7.0
#dlapp mysqld_exporter 0.12.1
#dlapp node_exporter 1.0.1
#dlapp pushgateway 1.3.0
#dlapp statsd_exporter 0.18.0
