#!/sbin/busybox sh

ROM=`cat /.firstrom/media/.rom`
[ -e /.firstrom/media/.rom ] || ROM=1

if [ $ROM != "1" ]; then
	mkdir -p /.firstrom/media/.${ROM}rom/system
	mkdir -p /.firstrom/media/.${ROM}rom/data
	mkdir -p /.firstrom/media/.${ROM}rom/cache

	chmod 0755 /.firstrom/media/.${ROM}rom/system
	chmod 0771 /.firstrom/media/.${ROM}rom/data
	chmod 0771 /.firstrom/media/.${ROM}rom/cache

	chown root /.firstrom/media/.${ROM}rom/system
	chown system /.firstrom/media/.${ROM}rom/data
	chown system /.firstrom/media/.${ROM}rom/cache

	chgrp root /.firstrom/media/.${ROM}rom/system
	chgrp system /.firstrom/media/.${ROM}rom/data
	chgrp cache /.firstrom/media/.${ROM}rom/cache

	mount --bind /.firstrom/media/.${ROM}rom/system /system
	mount --bind /.firstrom/media/.${ROM}rom/data /data
	mount --bind /.firstrom/media/.${ROM}rom/cache /cache

	/sbin/ext/mount.sh $ROM
else
	rm -rf /.firstrom
fi
