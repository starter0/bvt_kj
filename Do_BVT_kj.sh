#!/system/bin/sh
#
# Copyright Bykj
#									
#									
#	[History]	[VER]	[commecnt]
#	2019-02-27	0.1		Initial 		Newly Created.
#   2019-03-07	0.2		for test 		First release.
# 	2019-03-14  0.3     uplus 추가		Friends, U+ 나누기



#sh_version = 'Ver 0.3'

# who am I?
#uid = 'whoami'


################# Information to check ################

check_build_version='2.6.5.00'
check_sensory_version='4.5.5'
check_conexant_version='6.129.0.18'
check_cdk_version='2.6.6'
check_line_app_version='1.5.1.181221'
check_voice_remote_version='1.10.02'


#######################################################
#######################################################
#######################################################
##### Below is sh's
#######################################################
################# Global variable

# count for pass, fail
count_pass=0
count_fail=0


# Information current device
device_info=$(eval 'imutil f_info' 2>&1)

model_name=`getprop ro.product.model`
length_model_name=${#model_name}
last_model_name=${model_name:(length_model_name-1)}

build_version=`getprop ro.build.version.tag`

sensory_version_full=`logcat -d | grep SDK`
sensory_version="${sensory_version_full##* }"

conexant_version=`getprop persist.infr.cx_fwver`

cdk_version_full=`getprop debug.friendshome.version`
cdk_version="${cdk_version_full%*.*}"

line_app_version_full=`dumpsys package ai.clova.app.line | grep versionName`
line_app_version="${line_app_version_full##*=}"

voice_remote_version_full=`dumpsys package ai.clova.lguplus.voiceremote | grep versionName`
voice_remote_version="${voice_remote_version_full##*=}"



#
# variable for flag
#

flag_build_version=False
flag_sensory_version=False
flag_conexant_version=False
flag_cdk_version=False
flag_line_app_version=False
flag_voice_remote_version=False

# Path
#
#
# Function
#
#
exec_f_info () {
	eval 'imutil f_info > /sdcard/f_info.txt'
}

check_f_info() {
	
	for line in device_info; do
		
		
	done
}

check_sensory_version_func() {

	echo "Wiki's Sensory version is \t $check_sensory_version"
	echo "Device's Sensory version is \t $sensory_version"
	
	if [[ $sensory_version_full == *"SDK Library version"* ]]; then
		
		if [ $check_sensory_version == $sensory_version ] ; then
			echo "Sensory version MATCH"
			flag_sensory_version=True
		
			else
				echo "Sensory version NOT match"
				let count_fail=count_fail+1
		fi
				
			else 
				echo "There is no sensory version information"
			
	fi
	
	
	
	echo ""
	
}

check_conexant_version_func() {
	echo "Wiki's Conexant version is \t $check_conexant_version"
	echo "Device's Conexant version is \t $conexant_version"
	
	if [ $check_conexant_version == $conexant_version ] ; then
		echo "Conexant version MATCH"
		flag_conexant_version=True
		
		else
			echo "Conexant version NOT match"
			let count_fail=count_fail+1
	fi	
	echo ""
	
}

check_build_version_func () {

	echo "Wiki's build version is \t $check_build_version"
	echo "Device's build version is \t $build_version"
	
	# check build version 
	if [ $check_build_version == $build_version ]; then
		
		echo "Build version MATCH"
		flag_build_version=True

		else 
			echo "Build version NOT match"
	#		count_fail=`expr $count_fail + 1`
			let count_fail=count_fail+1
	fi
	echo ""
	
}

check_cdk_version_func () {

	echo "Wiki's CDK version is \t\t $check_cdk_version"
	echo "Device's CDK version is \t $cdk_version"
	
	# check CDK version
	if [ $check_cdk_version == $cdk_version ]; then
		
		echo "CDK version MATCH"
		flag_cdk_version=True
		
		else
			echo "CDK version NOT match"
			let count_fail=count_fail+1
	fi
	
	echo ""
	
}

check_line_app_version_func () {
	echo "Wiki's Line APP version is \t $check_line_app_version"
	echo "Device's Line APP version is \t $line_app_version"
	
	if [ $check_line_app_version == $line_app_version ]; then
		echo "Line APP version MATCH"
		flag_line_app_version=True
		
		else 
			echo "Line APP version NOT match"
			let count_fail=count_fail+1
	
	fi
	
	echo ""
}


check_voice_remote_version_func () {
	
	echo "Wiki's U+ IPTV version is \t $check_voice_remote_version"
	echo "Device's U+ IPTV version is \t $voice_remote_version"
	
	if [ $check_voice_remote_version == $voice_remote_version ]; then	
		echo "U+ IPTV version MATCH"
		flag_voice_remote_version=True
		
		else	
			echo "U+ IPTV version NOT match"
			let count_fail=count_fail+1
			
	fi
	
	echo ""
	
}

		
#check done	

main(){
	clear;
	echo "\t==========================================="
	echo "\t START BVT version check For Friends"
	echo "\t==========================================="
	
	check_build_version_func
	check_sensory_version_func
	check_conexant_version_func
	check_cdk_version_func
	
	#Check if device is for uplus 
	
	if [ $last_model_name == "L" ]; then
		check_voice_remote_version_func
	
		else 
				check_line_app_version_func
				
	fi
	
	echo "\t==========================================="
	echo "\t End BVT version check "
	echo "\t==========================================="
	
}

#Run 
main


#exec_f_info



