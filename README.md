# Push_swap

The goal of [this project](https://github.com/dfinnis/Push_swap/blob/master/subject.pdf) is to create:

* *push_swap*, A bespoke sorting algorithm which accepts integers as argument and prints how to sort them.
* *checker*, checks the output of *push_swap* sorts correctly.

Final Score 121/100


## Getting Started

First clone this repo.

```git clone https://github.com/dfinnis/Push_swap.git; cd Push_swap```

Make the binaries *push_swap* & *checker*.

```make```

Then run ........???????????????????????????????

```./???????????????????????????????????????```


## Stacks

The game is composed of 2 stacks, *a* & *b*.

Initially:
* *a* contains the numbers input as argument (unsorted).
* *b* is empty

The goal is to have all numbers sorted in stack *a*.


## Operations

The stacks are circular, so coded as circular doubly linked lists.

This game requires a bespoke sorting algorithm because of the limited operations:

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


## 






## Tests

<img src="https://github.com/dfinnis/Push_swap/blob/master/img/test.png" width="45%">

## Team

I wrote this project in a team with the wonderful [@svaskeli](https://github.com/sharvas)
