# Actual management system for the local computer cluster using Parallella.
# Designed for master parallella board (203)
# Fork: master
b=`tput bold`
n=`tput sgr0`


declare -a ipname=( 10.0.1.200 10.0.1.201 10.0.1.202 10.0.1.203 )

SSH ()
{ 
    num = 0
    echo "Running " $1
    while [[ $num < ${ipname[#]} ]]; do
        echo "----------------------------"
        ssh linaro@${ipname[0]} $1
    done
}
if [[ "$1" != "" ]]; then
    if [[ "$1" == "help" ]]; then
    	echo "Options include:: ${b}shutdown, tell, update, status, transfer${n}"
    elif [[ "$1" == "shutdown" ]]; then
    	echo "Shutting down cluster"
    	SSH 'echo linaro | sudo shutdown -h now'
    elif [[ "$1" == "tell" ]]; then
    	echo "Telling cluster" $2
    	SSH $2
    elif [[ "$1" == "update" ]]; then # Works, now expand
    	echo "Updating cluster"
    	SSH 'cd Parallella; git pull'
    elif [[ "$1" == "status" ]]; then
    	clear
        echo "----------------------------"
        echo "    Starting"
        echo "----------------------------"
        SSH 'ip addr show | grep "eth0" | grep "inet"'
    elif [[ "$1" == "transfer" ]]; then
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
