# Status new Saturday, April 11, 2015

clear
num=200
echo "Starting"
while [[ $num -le 203 ]]; do
	ssh linaro@192.168.0.$num ip addr show | grep "inet"
	num=$((num+1))
done