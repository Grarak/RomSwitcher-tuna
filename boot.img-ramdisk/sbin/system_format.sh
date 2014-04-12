#!/sbin/sh

BB="busybox"
ROM=$1

if $BB grep -q /data /proc/mounts; then
	system=/data/media/.${ROM}rom/system.img
else
	system=/.firstrom/media/.${ROM}rom/system.img
fi

$BB umount -f /system
$BB mkdir -p /system

$BB mount -t ext4 -o rw $system /system || exit 1
$BB rm -rf /system/*
$BB rm -rf /system/.*
$BB mke2fs -F -T ext4 $system || exit 1

exit 0
