# Status new Saturday, April 11, 2015

SSH ()
{ 
	num=200
	while [[ $num -le 203 ]]; do
        echo $num "using" $1
		ssh linaro@192.168.0.$num $1
		num=$((num+1))
	done
}

clear
num=200
echo "Starting"
while [[ $num -le 203 ]]; do
	SSH 'ip addr show | grep'
	num=$((num+1))
done