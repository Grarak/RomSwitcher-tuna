#!/bin/sh

rm -rf kernel.zip
rm -rf ramdisk.gz
find -name "*~" -exec rm -rf {} \;

build () {
    cd boot.img-ramdisk
    find . | cpio -o -H newc | gzip -9 > ../ramdisk.gz
    cd ..
    ./mkbootimg-$1 --kernel zImage --ramdisk ramdisk.gz --cmdline "console=ttyFIQ0 androidboot.console=ttyFIQ0 mem=1G vmalloc=768M omap_wdt.timer_margin=30 no_console_suspend" -o boot.img
}

if [ -e ~/.bash_profile ]; then
    build darwin
else
    build linux
fi

mv -v boot.img out/
cd out
zip -r kernel.zip META-INF boot.img
mv -v kernel.zip ../
cd ..
adb push kernel.zip /sdcard/
