#!/bin/sh
set -eu
export NEW_FSROOT_RO="$1"
shift
exec unshare -r -m sh -eu -c 'mount --rbind -- "$NEW_FSROOT_RO" /_fsroot_ro; mount --rbind /_fsroot_ro/etc /etc; echo 0 > /proc/sys/user/max_user_namespaces; exec setpriv --bounding-set=-all "$@"' _ "$@"
