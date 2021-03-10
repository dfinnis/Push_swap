#### -- Print Push_swap Header -- ####
printf "\E[H\E[2J"
echo "\x1b[1mLaunching Push_swap Performance Test...\x1B[0m"


limit=11500 ## Max number of operations for 500 numbers

#### -- unit_test() -- ####
unit_test()
{
	NUM=$1
	echo
	echo "\x1b[1m$NUM numbers case\x1b[0m"
	# update num (range), case (test runs), limit (exceed limit) when needed
	case=10 ##############################

	exceed=0
	count=0
	passed=0
	sum=0
	best=100000
	worst=0
	while [ $count -lt $case ]
	do
		count=$(($count + 1))
		arg=$(ruby -e "puts (1..$NUM).to_a.shuffle.join(' ')")
		# op=$(./push_swap $arg)
		# line=$(echo "$op" | wc -l)
		line=$(./push_swap $arg | wc -l)

		fail=$(./push_swap $arg | ./checker $arg)
		fail=$(echo $fail | grep -o "OK")
		if [ $fail == "OK" ]
		then
			passed=$(($passed + 1))
		fi
		echo "\r\x1B[32mSorted: $passed/$count\x1B[0m\c"

		sum=$(($sum + $line))
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
			exceed=$(($exceed + 1))
		fi
	done

	best=$(echo $best)
	worst=$(echo $worst)
	mean=$(($sum / $count))

	#### -- Solve length -- ####
	echo
	echo "Solve length:"
	if [ $best -le $limit ]
	then
		echo "\x1B[32mbest:  $best\x1B[0m"
	else
		echo "\x1B[33mbest:  $best\x1B[0m"
	fi
	if [ $mean -le $limit ]
	then
		echo "\x1B[32mmean:  $mean\x1B[0m"
	else
		echo "\x1B[33mmean:  $mean\x1B[0m"
	fi
	if [ $worst -le $limit ]
	then
		echo "\x1B[32mworst: $worst\x1B[0m"
	else
		echo "\x1B[33mworst: $worst\x1B[0m"
	fi
}

#### -- Input Length -- ####
unit_test 5
unit_test 100
unit_test 500
echo
echo
