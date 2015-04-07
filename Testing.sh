# Another new status
# Meant for general test scripts
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
