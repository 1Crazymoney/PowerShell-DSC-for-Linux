#!/bin/bash

if [ "$#" -ne 0 ]
then
	# Checking which python version is available 
	# python3
	if [[ -z $(python2 --version 2>&1 | grep 'not found') ]]
	then
		#echo "python exists"; 
		pythonVer="python"
	elif [[ -z $(python3 --version 2>&1 | grep 'not found') ]]
	then
		#echo "python3 exists"; 
		pythonVer="python3"
	else 
		echo "You do not have python on this machine"
		exit 1
	fi

	# Detemine file location
	echo "You provided the following argument(s): $@"
	if [ "$pythonVer" == "python" ] 
	then
		filePath="/opt/microsoft/omsconfig/Scripts/"
	else
		filePath="/opt/microsoft/omsconfig/Scripts/python3/"
	fi

	# Construct command from arguments
	for args in "$@"; do
		filePath+=$args
		filePath+=" "
	done
	echo "The path provided is: "
	echo $(ls $filePath)
	
	# Construct command
	echo "sudo su omsagent -c '$pythonVer $filePath'"
	sudo su omsagent -c "$pythonVer $filePath"
else
	echo "No parameters were passed."
fi

