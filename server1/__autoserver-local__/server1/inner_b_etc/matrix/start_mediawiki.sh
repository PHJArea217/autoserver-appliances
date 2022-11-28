#!/bin/sh
set -eu
mkdir -p /_fsroot_rw/ctr_local
cp /etc/matrix/php-fpm.conf /_fsroot_rw/ctr_local
ln -sfT /_fsroot_rw/ctr_local /ctr_local
for x in extensions skins images; do mkdir -p /_fsroot_rw/mediawiki/data/"$x"; done
mkdir -p -m 700 /_fsroot_rw/mediawiki/data/private
chown 'mediawiki:mediawiki' /_fsroot_rw/mediawiki/data/images /_fsroot_rw/mediawiki/data/private
exec nsenter --net=/run/netns/__host__ /ctr_fs1/_system/bin/ctrtool ns_open_file -n -d unix -P /run/mediawiki.sock -l 4096 sh -eu -c 'chown "root:www-data" /run/mediawiki.sock; chmod 660 /run/mediawiki.sock; export FPM_SOCKETS="/run/mediawiki.sock=$CTRTOOL_NS_OPEN_FILE_FD_0"; exec "$@"' _ /ctr_fs1/_system/bin/ctrtool launcher --escape -sL /var/log/mediawiki.log -Um --uid-map=33.132.1 --gid-map=33.132.1 -S 33 -G 33 -k -a inherit sh -c 'set -eu; /ctr_fs1/_system/bin/ctrtool mount_seq -m /ctr_fs2/mediawiki/etc/resolv.conf -s /etc/resolv.conf-pjtl -Ob -m /_fsroot_ro -s /ctr_fs2/mediawiki -Obv -m /etc -s /_fsroot_ro/etc -Obv -m /_fsroot_rw/var -s /_fsroot_ro/var -Ob -m /_fsroot_rw/var/www/html/extensions -s /_fsroot_rw/mediawiki/data/extensions -Ob -m /_fsroot_rw/var/www/html/skins -s /_fsroot_rw/mediawiki/data/skins -Ob -m /tmp -o mode=0755 -t tmpfs -l /tmp/mysql.sock -s /run/mysqld/mysqld.sock; cd /_fsroot_rw/var/www/html; exec setpriv --inh-caps=-all --no-new-privs /usr/local/sbin/php-fpm -y /ctr_local/php-fpm.conf'
