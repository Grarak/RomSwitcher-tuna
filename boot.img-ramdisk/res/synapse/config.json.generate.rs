#!/sbin/busybox sh

cat << CTAG
{
    name:RomSwitcher,
    elements:[
`
for ROM in 1 2 3 4 5 ; do
	echo '{ SButton:{
                label:"Reboot to ROM '${ROM}'",
                action:"rs reboot '$ROM'"
        }},'
done
`
	{ SButton:{
                label:"Reboot to RomSwitcher Recovery",
                action:"rs recovery"
        }},
    ]
}
CTAG
