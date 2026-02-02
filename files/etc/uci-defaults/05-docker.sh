mkdir -p /opt/docker
uci set dockerd.globals.data_root='/opt/docker'
uci commit dockerd
