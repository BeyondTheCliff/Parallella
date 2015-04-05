# Actual management system for the local computer cluster using Parallella.
# Designed for master parallella board (203)
bold=`tput bold`
normal=`tput sgr0`

SSH ()
{ 
	num=200
	while [ $num -le 203 ]; do
		ssh linaro@192.168.0.$num $1
		echo $num "using" $1
		num=$((num+1))
	done
}


if [ "$1" != "" ]; then
    if [ "$1" == "help" ]; then
    	echo "Options include:: ${bold}shutdown, tell, update, status${normal}"
    elif [ "$1" == "shutdown" ]; then
    	echo "Shutting down cluster"
    	PSSWD="linaro"
    	SSH 'echo $PSSWD | sudo shutdown -h now'
    elif [ "$1" == "tell" ]; then
    	echo "Telling cluster" $2
    	SSH $2
    elif [ "$1" == "update" ]; then
    	echo "Updating cluster"
    	SSH 'git clone https://github.com/OSM12345/Parallella.git'
    elif [ "$1" == "status" ]; then # Needs to be updated to Status.sh
    	echo "Starting Status Check"
    	num=200
    	while [ $num -le 203 ]; do
    		ping -c2 192.168.0.$num # Needs silent ping. 
    		ret=$?
    		if [ $ret -eq 0 ]; then
				echo $num "${bold}good${normal}"
			else
				echo $num "${bold}bad${normal}"
			fi
			num=$((num+1))
    	done
    elif [ "$1" == "transfer"]; then
        echo "Copying Now"
        scp $2 linaro@192.168.0.200:$3
        scp $2 linaro@192.168.0.201:$3
        scp $2 linaro@192.168.0.202:$3
    else
    	echo "Bad Command"
    fi
else
    echo "Positional parameter 1 is empty. \nUse 'help' as an argument"
fi