#!/sbin/busybox sh

ROM=`cat /.firstrom/media/.rom`

mkdir -p /.firstrom/media/.${ROM}rom/data
mkdir -p /.firstrom/media/.${ROM}rom/cache
chmod 775 /.firstrom/media/.${ROM}rom/data
chmod 775 /.firstrom/media/.${ROM}rom/cache
mount -t ext4 -o rw /.firstrom/media/.${ROM}rom/system.img /system
mount --bind /.firstrom/media/.${ROM}rom/data /data
mount --bind /.firstrom/media/.${ROM}rom/cache /cache

chmod 755 /system

/sbin/ext/mount.sh $ROM
