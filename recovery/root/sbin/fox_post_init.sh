#!/sbin/sh
#
# - /sbin/fox_post_init.sh
# - Custom post_init script for OrangeFox Recovery
# - Author: DarthJabba9
# - Date: 12 May 2018
#
# * Fix yellow flashlight issue in Mido and Vince
#
#

# replicate the "write" command of init rc files
write() {
  [ -e $1 ] && {
    [ -n "$2" ] && echo "$2" > $1
  }
}

# for mido
do_mido() {
   write /sys/devices/soc/qpnp-flash-led-25/leds/led:torch_1/max_brightness 0
   write /sys/class/leds/led:torch_1/max_brightness 0
   write /sys/class/leds/torch-light1/max_brightness 0 
   write /sys/class/leds/led:flash_1/max_brightness 0
}

# for vince
do_vince() {
   do_mido
}

# we don't know you
not_known() {
   echo "Unknown device"
}

# start
DEV=$(getprop "ro.product.device")
case "$DEV" in
	mido)
	do_mido;
	;;

	vince)
	do_vince;
	;;
        
        *)
        not_known;
        ;;
esac

setprop orangefox.postinit.status 1

