#### -- Print Push_swap Header -- ####
printf "\E[H\E[2J"
echo "\x1b[1mLaunching Push_swap Performance Test...\x1B[0m"

case_start=40 ## Number of test runs
#### -- unit_test() -- ####
unit_test()
{
	## Numbers case
	NUM=$1
	LIMIT=$2
	echo
	echo "\x1b[1m$NUM numbers case\x1b[0m"

	## Initialize var
	case=$case_start ## Number of test runs
	case_start=$(($case_start / 2))
	exceed=0
	count=0
	passed=0
	sum=0
	best=100000
	worst=0
	sum_time=0
	best_time=420000000000
	worst_time=-420000000000

	## Testloop
	while [ $count -lt $case ]
	do
		count=$(($count + 1))
		arg=$(ruby -e "puts (1..$NUM).to_a.shuffle.join(' ')")

		start=$(gdate +%s%N)
		op=$(./push_swap $arg) ## Run push_swap

		## Time
		end=$(gdate +%s%N)
		runtime=$( echo "($end - $start)" | bc -l )
		if [ $runtime -lt $best_time ]
		then
			best_time=$runtime
		fi
		if [ $runtime -gt $worst_time ]
		then
			worst_time=$runtime
		fi
		sum_time=$(($sum_time + $runtime))

		## Pass / Fail
		fail=$(./push_swap $arg | ./checker $arg)
		fail=$(echo $fail | grep -o "OK")
		if [ $fail == "OK" ]
		then
			passed=$(($passed + 1))
		fi
		## Print Pass
		if [ $passed == $count ]
		then
			echo "\r\x1B[32mSorted: $passed/$count\x1B[0m\c"
		else
			echo "\r\x1B[33mSorted: $passed/$count\x1B[0m\c"
		fi

		## Solve length
		line=$(echo "$op" | wc -l)
		sum=$(($sum + $line))
		if [ $line -lt $best ]
		then
			best=$line
		fi
		if [ $line -gt $worst ]
		then
			worst=$line
		fi
	done

	## Solve length calc
	best=$(echo $best)
	worst=$(echo $worst)
	mean=$(($sum / $count))
	mean_time=$(($sum_time / $count))

	## Time decimal places
	mean_int=$( echo "scale=0; $mean_time / 1000000000" | bc -l )
	best_int=$( echo "scale=0; $best_time / 1000000000" | bc -l )
	worst_int=$( echo "scale=0; $worst_time / 1000000000" | bc -l )

	mean_time=$( echo "scale=3; $mean_time / 1000000000" | bc -l )
	best_time=$( echo "scale=3; $best_time / 1000000000" | bc -l )
	worst_time=$( echo "scale=3; $worst_time / 1000000000" | bc -l )

	## Print Solution length
	echo
	echo "Solution Length:"
	if [ $best -le $LIMIT ]
	then
		echo "\x1B[32mbest:  $best\x1B[0m"
	else
		echo "\x1B[33mbest:  $best\x1B[0m"
	fi
	if [ $mean -le $LIMIT ]
	then
		echo "\x1B[32mmean:  $mean\x1B[0m"
	else
		echo "\x1B[33mmean:  $mean\x1B[0m"
	fi
	if [ $worst -le $LIMIT ]
	then
		echo "\x1B[32mworst: $worst\x1B[0m"
	else
		echo "\x1B[33mworst: $worst\x1B[0m"
	fi

	## Print Solve Time
	echo "Solve Time:"
	if [ $best_int -le "1" ]
	then
		echo "\x1B[32mbest:  $best_time s\x1B[0m"
	else
		echo "\x1B[33mbest:  $best_time\x1B[0m"
	fi
	if [ $mean_int -le "1" ]
	then
		echo "\x1B[32mmean:  $mean_time s\x1B[0m"
	else
		echo "\x1B[33mmean:  $mean_time\x1B[0m"
	fi
	if [ $worst_int -le "1" ]
	then
		echo "\x1B[32mworst: $worst_time s\x1B[0m"
	else
		echo "\x1B[33mworst: $worst_time\x1B[0m"
	fi
}

#### -- Call unit_test() -- ####
## unit_test( NUM LIMIT )
unit_test 5 12
unit_test 100 1000
unit_test 500 11500
echo
echo
