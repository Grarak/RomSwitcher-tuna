#!/sbin/busybox sh

mount -o remount,rw /system
/sbin/busybox mount -t rootfs -o remount,rw rootfs

echo 2 > /sys/devices/system/cpu/sched_mc_power_savings

for i in /sys/block/*/queue/add_random;do echo 0 > $i;done

echo 0 > /proc/sys/kernel/randomize_va_space

echo 180000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 1200000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq

echo "-10 0 -10" > /sys/class/misc/colorcontrol/v1_offset
echo "1800000000 1800000000 2000000000" > /sys/class/misc/colorcontrol/multiplier
echo 0 > devices/virtual/misc/fsynccontrol/fsync_enabled

mkdir -p /mnt/ntfs
chmod 777 /mnt/ntfs
mount -o mode=0777,gid=1000 -t tmpfs tmpfs /mnt/ntfs

if [ -d /system/etc/init.d ]; then
	/sbin/busybox run-parts /system/etc/init.d
fi;

mount -t tmpfs tmpfs /system/lib/modules

ln -s /lib/modules/* /system/lib/modules/

/sbin/busybox mount -t rootfs -o remount,ro rootfs
mount -o remount,ro /system
