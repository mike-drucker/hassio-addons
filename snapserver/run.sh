#!/usr/bin/env bashio

mkdir -p /share/snapfifo
mkdir -p /share/snapcast
bashio::log.info "Starting SnapServer..."
/usr/bin/snapserver
