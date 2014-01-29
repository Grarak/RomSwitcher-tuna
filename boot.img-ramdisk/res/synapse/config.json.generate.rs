#!/sbin/busybox sh

cat << CTAG
{
    name:RomSwitcher,
    elements:[
	{ STitleBar:{
		title:"RomSwitcher Settings"
	}},
`
for ROM in 1 2 3 4 5 ; do
	echo '{ SButton:{
                label:"Reboot to ROM '${ROM}'",
                action:"rs reboot '$(($ROM-1))'"
        }},'
done
`
	{ SButton:{
                label:"Reboot to RomSwitcher Recovery",
                action:"rs recovery"
        }},
	{ SCheckBox:{
                description:"Enable App Sharing between 1st and 2nd rom.",
                label:"Enable App Sharing",
                action:"rs appshare"
        }},
	{ SCheckBox:{
                description:"Enable Data Sharing between 1st and 2nd rom.",
                label:"Enable Data Sharing",
                action:"rs datashare"
        }},
	{ SCheckBox:{
                description:"Choose a rom at startup.",
                label:"Enable Manual Boot",
                action:"rs manualboot"
        }},
    ]
}
CTAG
