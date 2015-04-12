# Status new Saturday, April 11, 2015
# Done, moving to Cluster

clear
num=200
echo "    Starting"
echo "----------------------------"
while [[ $num -le 203 ]]; do
	ssh linaro@192.168.0.$num ip addr show | grep "192.168."
	echo "----------------------------"
	num=$((num+1))
done