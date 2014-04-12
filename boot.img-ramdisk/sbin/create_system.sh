#!/sbin/sh

BB="busybox"
ROM=$1

path=/data/media/.${ROM}rom

if $BB [ ! -f $path/system.img ] ; then
	$BB mkdir -p $path
	# create a file 700MB
	$BB dd if=/dev/zero of=$path/system.img bs=1024 count=716800 || exit 1
	# create ext4 filesystem
	$BB mke2fs -F -T ext4 $path/system.img || exit 1
fi

exit 0
