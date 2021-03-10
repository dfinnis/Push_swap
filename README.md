# Push_swap

The goal of [this project](https://github.com/dfinnis/Push_swap/blob/master/subject.pdf) is to create:

* **push_swap**, A bespoke sorting algorithm which accepts integers as argument and prints how to sort them.
* **checker**, checks the output of *push_swap* sorts correctly.

Final Score 121/100


## Getting Started

First clone this repo.

```git clone https://github.com/dfinnis/Push_swap.git; cd Push_swap```

Make the binaries *push_swap* & *checker*.

```make```

Then run *push_swap* with integers as argument, *push_swap* prints a list of operations to sort the numbers. Pipe *push_swap* output into *checker*, provide the same numbers as argument, *checker* prints OK if the numbers are sorted correctly.

```ARG="1 5 2 4 3"; ./push_swap $ARG | ./checker $ARG```

<img src="https://github.com/dfinnis/Push_swap/blob/master/img/simple.png" width="70%">

Alternatively, run with this handy ruby shuffle, which tests 5 numbers like above but in a random order.

```ARG=`ruby -e "puts (1..5).to_a.shuffle.join(' ')"`; ./push_swap $ARG | ./checker $ARG```

<img src="https://github.com/dfinnis/Push_swap/blob/master/img/shuffle.png" width="100%">


## Stacks

The game is composed of 2 stacks, *a* & *b*.

Initially:
* *a* contains the numbers input as argument (unsorted).
* *b* is empty

The goal is to have all numbers sorted in stack *a*. Shorter solutions (less operations) are better.

The stacks are circular, so coded as circular doubly linked lists.

This game also requires a bespoke sorting algorithm because you are only allowed to use the following operations.


## Operations

**Rotate** stacks, changing which element is at the "top" of the stack.

* `ra` : rotate *a* - shift up all elements of stack *a* by 1.
* `rb` : rotate *b* - shift up all elements of stack *b* by 1.
* `rr` : ra and rb at the same time.
* `rra` : reverse rotate *a* - shift down all elements of stack *a* by 1.
* `rrb` : reverse rotate *b* - shift down all elements of stack *b* by 1.
* `rrr` : rra and rrb at the same time.

**Push** the top element to the other stack.

* `pa` : push *a* - take the first element at the top of *b* and put it at the top of *a*.
* `pb` : push *b* - take the first element at the top of *a* and put it at the top of *b*.

**Swap** the top 2 elements in a stack.

* `sa` : swap *a* - swap the first 2 elements at the top of stack *a*.
* `sb` : swap *b* - swap the first 2 elements at the top of stack *b*.
* `ss` : sa and sb at the same time.


## push_swap

*push_swap* takes integers as argument, and prints a list of operations to sort the numbers.

```ARG="1 5 2 4 3"; ./push_swap $ARG```

<img src="https://github.com/dfinnis/Push_swap/blob/master/img/push_swap.png" width="55%">

#### Flag *-f file_name*

Write instructions to file_name, instead of default stdout.

```ARG="1 5 2 4 3"; ./push_swap -f solution $ARG; cat solution```


## checker

*checker* expects numbers as arguments in the same format as *push_swap*. *checker* then waits to receive operations on stdin, one operation per line.

In the following example, we provide numbers 2, 1 then 3 as argument, then operation *sa* to stdin. Finally press *ctrl + d* to end stdin input.

<img src="https://github.com/dfinnis/Push_swap/blob/master/img/checker.png" width="40%">


#### Visualizer

Flags *-v* visualizer, *-c* colour last operation, & *-t* slow visualizer

```ARG=`ruby -e "puts (1..12).to_a.shuffle.join(' ')"`; ./push_swap $ARG | ./checker -c -t $ARG```

![visualizer](https://github.com/dfinnis/Push_swap/blob/master/img/visualizer.gif)

Visualizer built with [ft_printf](https://github.com/dfinnis/ft_printf).


#### Flag *-f file_name*

Read instructions from file_name, instead of default stdin.

```ARG=`ruby -e "puts (1..100).to_a.shuffle.join(' ')"`; ./push_swap -f solution $ARG ; ./checker -f solution $ARG```

<img src="https://github.com/dfinnis/Push_swap/blob/master/img/f.png" width="100%">


## Sorting algo

For less than 100 numbers, the stack is initially divided in 3 according to value: top, middle and bottom third.
We start by rotating through the whole of stack *a* and pushing to *b* the top third (the largest numbers).
Then we look for min and max in *b*, and push back to *a* the least 'expensive' one.
Once we have organized the top third back in *a*, we repeat the process with the middle and bottom thirds.

For over 100 numbers, we intially divide the stack into 7 parts. Several other optimizations exploit all allowed moves to reduce solution length.

Here is a visualization of our solving algo, [visualiser by o-reo](https://github.com/o-reo/push_swap_visualizer).

![algo](https://github.com/dfinnis/Push_swap/blob/master/img/visualizer2.gif)


## Tests

I wrote test_performance.sh to test randomly shuffled lists of 5, 100 and 500 numbers long.

```./test_performance.sh```

<img src="https://github.com/dfinnis/Push_swap/blob/master/img/test.png" width="45%">


## Team

I wrote this project in a team with the wonderful [@svaskeli](https://github.com/sharvas)
