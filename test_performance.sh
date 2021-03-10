#### -- Print Push_swap Header -- ####
printf "\E[H\E[2J"
echo "\x1b[1mLaunching Push_swap Performance Test...\x1B[0m"

#### -- unit_test() -- ####
unit_test()
{
	NUM=$1
	echo
	echo "\x1b[1m$NUM numbers case\x1b[0m"
	# update num (range), case (test runs), limit (exceed limit) when needed
	case=10 ###############################
	limit=11500

	exceed=0
	count=1
	sum=0
	best=100000
	worst=0
	fail="OK"
	while [ $count -lt $(expr $case + 1) ]
	do
		arg=$(ruby -e "puts (1..$NUM).to_a.shuffle.join(' ')")
		echo "\r-- $count/$case --\c"
		line=$(./push_swap $arg | wc -l)
		sum=$(expr $sum + $line)
		if [ $line -lt $best ]
		then
			best=$line
		fi
		if [ $line -gt $worst ]
		then
			worst=$line
		fi
		if [ $line -gt $limit ]
		then
			exceed=$(expr $exceed + 1)
		fi
		count=$(expr $count + 1)
	done
	fail=$(./push_swap $arg | ./checker $arg)
	best=$(echo $best)
	worst=$(echo $worst)
	echo " "
	echo "range         : 1 to $NUM"
	echo "test runs     : $case"
	echo "avg moves     : $(expr $sum / $(expr $count - 1))"
	echo "best          : $best"
	echo "worst         : $worst"
	echo "KO if failed  : $fail"
	echo "exceed max    : $exceed"
	echo
}

#### -- Input Length -- ####
unit_test 5
unit_test 100
unit_test 500
