#!/bin/sh
mkdir -p /var/log/nginx /var/lib/nginx
exec nsenter --net=/run/netns/__host__ env SKBOX_DIRECTORY_ROOT2=/run/socketbox LD_PRELOAD=/ctr_fs1/_system/bin/libsocketbox-preload.so nginx
