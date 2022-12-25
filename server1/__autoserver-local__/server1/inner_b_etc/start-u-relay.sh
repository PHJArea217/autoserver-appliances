#!/bin/sh

set -eu
cd /etc/node_app

exec /ctr_fs1/_system/bin/ctrtool ns_open_file -o10 \
	-n -N /run/netns/__host__ -d inet -4 127.0.0.10,81,a -l4096 \
	-n -N /run/netns/__host__ -6 '::,1080,a' -l4096 \
	setpriv --reuid=matrix-synapse --regid=matrix-synapse --clear-groups \
	env NODE_PATH=/ctr_fs2/node_js/usr/local/lib/node_modules \
	LD_PRELOAD='/ctr_fs1/_system/bin/libsocketbox-preload.so:/usr/local/lib/socket-enhancer' \
	SOCKET_ENHANCER_CONFIG='bdpr=16384/Dvpn_vrf0,bdpr=32768/Dvpn_vrf0' \
	SKBOX_DIRECTORY_ROOT2=/run/socketbox \
	/ctr_fs2/node_js/usr/local/bin/node entrypoint.js '{"transparent_fd": {"host": "fe8f::2:2:1", "port": 80}, "socks_fd": {"host": "fe8f::2:2:1", "port": 81}, "prefix": "0xfd48774fd9a1810b", "dns": ["127.0.0.1"]}'
