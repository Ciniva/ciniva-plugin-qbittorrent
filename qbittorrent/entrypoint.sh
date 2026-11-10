#!/bin/sh
set -e
conf=/config/qBittorrent/config/qBittorrent.conf
if [ ! -e "$conf" ]; then
    mkdir -p "${conf%/*}"
    cp /defaults/qBittorrent.conf "$conf"
fi
exec /usr/local/bin/qbittorrent-nox --profile=/config --webui-port=8080 --confirm-legal-notice "$@"
