# Status place holder
# Fork real version
# Implemented
num=0
bold=`tput bold`
normal=`tput sgr0`
clear
ping -q -c3 www.google.com > /dev/null
ret=$?
if [ $ret==1 ]; then
	clear
	echo "------------------------------"
	echo "Google Sever Status - ${bold}Online${normal}"
	echo "------------------------------"
else
	clear
	echo "------------------------------"
	echo "Google Server Status - ${bold}Offline${normal}"
	echo "------------------------------"
fi

printf "\033[1A"
while [ $num -le 5 ]; do
	num=$((num+1))
	#echo "Pinging"
	ping -q -c3 www.google.com > /dev/null
	ret=$?
	if [ $ret==1 ]; then
		printf "\033[1A"
		if [ $(($num % 2)) -eq 0 ]; then
		  echo "Google Sever Status - ${bold}Online-${normal}"
		else
		  echo "Google Sever Status - ${bold}Online${normal}"
		fi
	else
		printf "\033[1A"
		echo "Google Server Status - ${bold}Offline${normal}"
	fi
	sleep 1
done
clear