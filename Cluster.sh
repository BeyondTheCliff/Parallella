# Actual management system for the local computer cluster using Parallella.
# Designed for master parallella board (203)
# Fork: Status
bold=`tput bold`
normal=`tput sgr0`

SSH ()
{ 
	num=200
	while [ $num -le 203 ]; do
        echo $num "using" $1
		ssh linaro@192.168.0.$num $1
		num=$((num+1))
	done
}


if [ "$1" != "" ]; then
    if [ "$1" == "help" ]; then
    	echo "Options include:: ${bold}shutdown, tell, update, status, transfer${normal}"
    elif [ "$1" == "shutdown" ]; then
    	echo "Shutting down cluster"
    	SSH 'echo linaro | sudo shutdown -h now'
    elif [ "$1" == "tell" ]; then
    	echo "Telling cluster" $2
    	SSH $2
    elif [ "$1" == "update" ]; then # Needs testing
    	echo "Updating cluster"
    	SSH 'cd Parallella; git pull'
    elif [ "$1" == "status" ]; then # Done
    	num=200
        clear
        while [[ $num -le 203 ]]; do
            echo "Pinging"
            ping -q -c3 192.168.0.$num > /dev/null
            ret=$?
            if [[ ret==1 ]]; then
                echo "---------------------------------------------"
                echo "Parallella Board ${bold}$num${normal} Status is ${bold}Online${normal}"
                echo "---------------------------------------------"
            else
                echo "---------------------------------------------"
                echo "Parallella Board ${bold}$num${normal} Status is ${bold}Offline${normal}"
                echo "---------------------------------------------"
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
    echo "Positional parameter 1 is empty. Use 'help' as an argument"
fi