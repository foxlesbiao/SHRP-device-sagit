#
# Copyright (C) 2017 The Android Open Source Project
#
# Copyright (C) 2019-2020 OrangeFox Recovery Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#
#
FDEVICE="sagit"
#OF_SUPPORT_SAR="1"

Configure_OF_SAR_Settings() {
local SCRIPTNAME="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
local SCRIPTPATH=$(dirname $SCRIPTNAME)
local FF_FSTAB=$SCRIPTPATH/recovery.fstab
local FF_RC=$SCRIPTPATH/recovery/root/init.recovery.qcom.rc
local TAG="#disabled=#"
local SYS_ROOT="/system_root"
   if [ -f $FF_RC ] && [ -f $FF_FSTAB ]; then
   	local F=$(grep "$TAG" $FF_FSTAB)
   	local G=$(grep "$TAG" $FF_RC)
   	if [ "$OF_SUPPORT_SAR" = "1" ]; then
   	   export BOARD_BUILD_SYSTEM_ROOT_IMAGE="true"
   	   export OF_SUPPORT_PRE_FLASH_SCRIPT="1"  
	   [ -n "$F" ] && sed -i -e "s|$TAG||" $FF_FSTAB
	   [ -n "$G" ] && sed -i -e "s|$TAG||" $FF_RC
   	else
	   [ -z "$F" ] && sed -i -e 's|'"$SYS_ROOT"' ext4 |'"$TAG"''"$SYS_ROOT"' ext4 |' $FF_FSTAB
	   [ -z "$G" ] && sed -i -e 's|export ANDROID_ROOT '"$SYS_ROOT"'|'"$TAG"'export ANDROID_ROOT '"$SYS_ROOT"'|' $FF_RC  
   	fi
   fi
}

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
   	export PLATFORM_VERSION=10.0.0
   	export PLATFORM_SECURITY_PATCH="2099-12-31"
   	export OF_OTA_RES_DECRYPT=1
   	export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
   	export FOX_REPLACE_BUSYBOX_PS=1
   	export FOX_USE_BASH_SHELL=1
   	export FOX_USE_NANO_EDITOR=1
   	export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1

#   	Configure_OF_SAR_Settings   

add_lunch_combo omni_"$FOX_BUILD_DEVICE"-eng
add_lunch_combo omni_"$FOX_BUILD_DEVICE"-userdebug
fi
#
