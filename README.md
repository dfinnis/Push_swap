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

The goal is to have all numbers sorted in stack *a*.

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

<img src="https://github.com/dfinnis/Push_swap/blob/master/img/push_swap.png" width="70%">

* Flag *-f file_name*, write instructions to file_name, instead of default stdout.

```ARG="1 5 2 4 3"; ./push_swap -f solution $ARG; cat solution```


## checker

*checker* expects numbers as arguments in the same format as *push_swap*. *checker* then waits to receive operations on stdin, one operation per line.

In the following example, we provide numbers 2, 1 then 3 as argument, then operation *sa* to stdin. Finally press *ctrl + d* to end stdin input.

<img src="https://github.com/dfinnis/Push_swap/blob/master/img/checker.png" width="45%">


* Flags *-v* visualizer, *-c* colour last operation, & *-t* slow visualizer

```ARG=`ruby -e "puts (1..12).to_a.shuffle.join(' ')"`; ./push_swap $ARG | ./checker -c -t $ARG```

![visualizer](https://github.com/dfinnis/Push_swap/blob/master/img/visualizer.gif)


* Flag *-f file_name*, read instructions from file_name, instead of default stdin.

```ARG=`ruby -e "puts (1..12).to_a.shuffle.join(' ')"`; ./push_swap -f solution $ARG ; ./checker -f solution $ARG```

<img src="https://github.com/dfinnis/Push_swap/blob/master/img/f.png" width="100%">


## Tests

<img src="https://github.com/dfinnis/Push_swap/blob/master/img/test.png" width="45%">

## Team

I wrote this project in a team with the wonderful [@svaskeli](https://github.com/sharvas)
