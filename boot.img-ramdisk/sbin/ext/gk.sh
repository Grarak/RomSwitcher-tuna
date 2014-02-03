#!/sbin/busybox sh

mount -o remount,rw /system
/sbin/busybox mount -t rootfs -o remount,rw rootfs

if grep -q GraKernel /proc/version ; then
	for i in /sys/block/*/queue/add_random; do echo 0 > $i;done

	echo 0 > /proc/sys/kernel/randomize_va_space

	echo 2 > /sys/devices/system/cpu/sched_mc_power_savings
	echo 180000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo 1200000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	echo 350000 > /sys/devices/system/cpu/cpu0/cpufreq/screen_off_max_freq

	echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/gpu_oc

	echo -5 > /sys/module/panel_s6e8aa0/parameters/contrast
	echo 5 > /sys/devices/platform/omapdss/manager0/gamma
	echo -5 -3 7 > /sys/class/misc/colorcontrol/v1_offset
	echo 0 > /sys/class/misc/colorcontrol/safety_enabled
	echo 2600000000 2760000000 3000000000 > /sys/class/misc/colorcontrol/multiplier

	echo 1 > /sys/devices/virtual/misc/soundcontrol/highperf_enabled
	echo 2 > /sys/devices/virtual/misc/soundcontrol/volume_boost

	sysctl -w net.ipv4.tcp_congestion_control=westwood
	echo 1 > /sys/kernel/dyn_fsync/Dyn_fsync_active

	ln -s /res/synapse/uci /sbin/uci
	/sbin/uci

	mkdir -p /mnt/ntfs
	chmod 777 /mnt/ntfs
	mount -o mode=0777,gid=1000 -t tmpfs tmpfs /mnt/ntfs

	[ -d /system/etc/init.d ] && /sbin/busybox run-parts /system/etc/init.d

	mount -t tmpfs tmpfs /system/lib/modules

	ln -s /lib/modules/* /system/lib/modules/
fi

/sbin/busybox mount -t rootfs -o remount,ro rootfs
mount -o remount,ro /system
