#!/usr/bin/env sh
DIR=~/Downloads
MIRROR=https://github.com/prometheus

# https://github.com/prometheus/prometheus/releases/download/v2.11.1/prometheus-2.11.1.darwin-amd64.tar.gz
# https://github.com/prometheus/alertmanager/releases/download/v0.18.0/alertmanager-0.18.0.darwin-amd64.tar.gz

dl()
{
    APP=$1
    VER=$2
    OS=$3
    ARCH=$4
    FILE=${APP}-${VER}.${OS}-${ARCH}.tar.gz
    URL=$MIRROR/$APP/releases/download/v${VER}/$FILE
    LFILE=$DIR/$FILE

    if [ ! -e $LFILE ];
    then
        wget -q -O $LFILE $URL
    fi

    printf "      # %s\n" $URL
    printf "      %s-%s: sha256:%s\n" $OS $ARCH `sha256sum $LFILE | awk '{print $1}'`
}

dlapp()
{
    APP=$1
    VER=$2
    printf "  %s:\n" $APP
    printf "    '%s':\n" $VER
    for os in darwin linux windows
    do
        dl $APP $VER $os amd64
    done
}

dlapp prometheus 2.13.1
dlapp alertmanager 0.19.0
dlapp blackbox_exporter 0.15.1
dlapp consul_exporter 0.5.0
dlapp graphite_exporter 0.6.2
dlapp haproxy_exporter 0.10.0
dlapp memcached_exporter 0.6.0
dlapp mysqld_exporter 0.12.1
dlapp node_exporter 0.18.1
dlapp pushgateway 1.0.0
dlapp statsd_exporter 0.12.2
