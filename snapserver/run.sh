#!/usr/bin/env bashio

mkdir -p /share/snapfifo
mkdir -p /share/snapcast

config=/etc/snapserver.conf

if ! bashio::fs.file_exists '/etc/snapserver.conf'; then
    touch /etc/snapserver.conf ||
        bashio::exit.nok "Could not create snapserver.conf file on filesystem"
fi
bashio::log.info "Populating snapserver.conf..."

# Start creation of configuration
bashio::log.info " 1 "
echo "[stream]" > "${config}"
for stream in $(bashio::config 'stream.streams'); do
    bashio::log.info " A "
    echo "stream = ${stream}" >> "${config}"
done
bashio::log.info " 2 "
echo "buffer = $(bashio::config 'stream.buffer')" >> "${config}"
bashio::log.info " 3 "
echo "codec = $(bashio::config 'stream.codec')" >> "${config}"
echo "send_to_muted = $(bashio::config 'stream.send_to_muted')" >> "${config}"
echo "sampleformat = $(bashio::config 'stream.sampleformat')" >> "${config}"
bashio::log.info " 4 "
echo "[http]" >> "${config}"
echo "enabled = $(bashio::config 'http.enabled')" >> "${config}"
echo "doc_root = $(bashio::config 'http.docroot')" >> "${config}"
bashio::log.info " 5 "
echo "[tcp]" >> "${config}"
echo "enabled = $(bashio::config 'tcp.enabled')" >> "${config}"
bashio::log.info " 6 "
echo "[logging]" >> "${config}"
echo "debug = $(bashio::config 'logging.enabled')" >> "${config}"
bashio::log.info " ##### "
echo "[server]" >> "${config}"
echo "threads = $(bashio::config 'server.threads')" >> "${config}"
bashio::log.info " 7 "
echo "[server]" >> "${config}"
echo "datadir = $(bashio::config 'server.datadir')" >> "${config}"
bashio::log.info " 8 "
bashio::log.info "Starting SnapServer..."
cat /etc/snapserver.conf
/usr/bin/snapserver -c /etc/snapserver.conf
