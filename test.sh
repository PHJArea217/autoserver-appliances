#!/bin/sh
set -eu
case "$0" in
	*/*)
		cd "${0%/*}"
		;;
esac
tar -cC "$1" --owner=0 --group=0 . > 'root_modules/0.tar'
sha256sum -b root_modules/0.tar | head -c 64 > root_modules/0.manifest
find root_modules | cpio -o -H newc | xz -ce --check=crc32 | cat autoserver/as_boot/initrd.xz - > tmp_initrd.xz
qemu-system-x86_64 -enable-kvm -m 6144 -smp 4 -cpu host -net none -cdrom autoserver.iso -kernel autoserver/as_boot/vmlinuz -initrd tmp_initrd.xz -append 'autoserver_boot_dev=/dev/sr0 autoserver_boot_fstype=iso9660 autoserver_init=/__autoserver__/init_stage3_example autoserver_cgroupv1=0 autoserver_rwdisk_fstype=none'
