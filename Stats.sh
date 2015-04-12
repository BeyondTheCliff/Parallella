# Status new Saturday, April 11, 2015
clear
num=200
echo "Starting"
while [[ $num -le 203 ]]; do
	SSH 'ip addr show | grep'
	num=$((num+1))
done