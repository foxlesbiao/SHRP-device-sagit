#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2018-2020 The OrangeFox Recovery Project
#	
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
# 	
# 	Please maintain this if you use this script or any part of it
#
FDEVICE="sagit"
if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
   	export PLATFORM_VERSION="16.1.0"
   	export PLATFORM_SECURITY_PATCH="2099-12-31"
	export TW_DEFAULT_LANGUAGE="en"
   	export OF_OTA_RES_DECRYPT=1
   	export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
   	export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
	export OF_USE_MAGISKBOOT=1
	export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
 	export OF_FORCE_MAGISKBOOT_BOOT_PATCH_MIUI=1
   	export FOX_USE_BASH_SHELL=1
	export FOX_ASH_IS_BASH=1
   	export FOX_USE_NANO_EDITOR=1
	export FOX_USE_ZIP_BINARY=1
	export OF_FLASHLIGHT_ENABLE=0
	export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
	export FOX_REPLACE_BUSYBOX_PS=1
	export OF_USE_NEW_MAGISKBOOT=1
        export OF_KEEP_DM_VERITY="1"  # enabled for R10.1
	export OF_DISABLE_FORCED_ENCRYPTION="1"  # enabled for R10.1
	export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1

	# let's see what are our build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	   export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  	   export | grep "OF_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TW_" >> $FOX_BUILD_LOG_FILE
   	   export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
 	fi
  	
	add_lunch_combo omni_"$FDEVICE"-eng
	add_lunch_combo omni_"$FDEVICE"-userdebug
fi
#
