# Actual management system for the local computer cluster using Parallella.
bold=`tput bold`
normal=`tput sgr0`

SSH ()
{ 
	num=200
	while [ $num -le 203 ]; do
		ssh linaro@192.168.0.$num $1
		echo $num
		echo $1
		num=$((num+1))
	done
}


if [ "$1" != "" ]; then
    if [ "$1" == "help" ]; then
    	echo "Options include:: \n shutdown \n tell \n update \n status"
    elif [ "$1" == "shutdown" ]; then
    	echo "Shutting down cluster"
    	PSSWD="linaro"
    	SSH 'echo $PSSWD | sudo shutdown -h now'
    elif [ "$1" == "tell" ]; then
    	echo "Telling cluster" $2
    	SSH $2
    elif [ "$1" == "update" ]; then
    	echo "Updating cluster"
    	SSH 'apt-get update'
    elif [ "$1" == "status" ]; then
    	echo "starting"
    	num=200
    	while [ $num -le 203 ]; do
    		ping -c2 192.168.0.$num
    		ret=$?
    		if [ $ret -eq 0 ]; then
				echo $num "${bold}good${normal}"
			else
				echo $num "${bold}bad${normal}"
			fi
			num=$((num+1))
    	done
    else
    	echo "Bad Command"
    fi
else
    echo "Positional parameter 1 is empty. \nUse 'help' as an argument"
fi
