# Natural-Language-Processing-project
for a1:

Part 1

Implement a Scheme function permute to print all permutations of a given list of any length.

For example:

> (permute '(a e d))
(a e d)
(a d e)
(e a d)
(e d a)
(d a e)
(d e a)
#f
> (permute '())
#f
> (permute '(a))
(a)
#f
>
Notice that permute always returns #f. The permutations must be displayed to standard output, not returned. This is to avoid building enormous lists in memory (consider how many permutations there are of a list of length 10).

Part 2

Implement a Scheme function to compute path lengths (distances) in weighted directed graphs.

Scheme/Lisp lists, or s-expressions, give us a very easy way to represent a directed graphs. We'll use the association list convention here (but in general, you could also use other simple conventions).

We'll do the following to represent a weighted graph using incidence lists. A graph is an association list of (nodename . out-edges) pairs. Each nodename is just any unique symbol that identifies a node. Each out-edge is another association list of incident outgoing-edges, each of which is represented by a (destination-nodename . weight) pair. Each destination-nodename is a symbol that identifies the destination node. Each weight is a number.

For example:

(define g
  '((a . ((b . 5) (c . 8) (d . 3)))
   (b . ((a . 4) (c . 7)))
   (c . ((a . 2) (b . 6) (c . 2) (d . 9)))
   (d . ((b . 1) (c . 4)))))
We'll use weights that are positive integers representing the length or distance between any two points.

Write a function path-length that calculates the total sum of weights along any given path represented as a list of nodenames. Also write a convenient variation distance that lets you pass paths as a variable number of nodename arguments.

For example:

> (path-length g '(a c d b c))
25
> (distance g 'a 'c 'd 'b 'c)
25
> (distance g 'c 'c)
2
> (distance g 'd 'a)
#f
Notice that cycles are allowed, and distance must return #f if the path does not exist in the graph.


------------------------------------------------------------------------------------------------------------------------------


for a2:

Part 1

Extend your Scheme function permute from A1, to implement a new function anagram that takes an additional argument consisting of a list of symbols representing legal words. Your new function will print all permutations of a given list of any length, such that appending the symbols in the permuted list gives a legal word.

For example:

> (define dictionary '(a act ale at ate cat eat etc tea))
> (anagram dictionary '(a e t))
(a t e)
(e a t)
(t e a)
#f
> (anagram dictionary '(a t c))
(a c t)
(c a t)
#f
> (anagram dictionary '(a))
(a)
#f
> (anagram '() '(a e t))
#f
>
(Hint: You may wish to recall some potentially useful standard functions like symbol->string, string->symbol, string-append, etc.)

Notice that anagram always returns #f. The legal permutations must be displayed to standard output, not returned. This is to avoid building enormous lists in memory (consider how many permutations there are of a list of length 10).

Part 2

Consider the following my-or macro:

(define-macro my-or
  (lambda (x y)
    `(if ,x ,x ,y)))
For simple cases, this works fine:

> (my-or 1 2)
1
> (my-or #f 2)
2
>
But what happens here?

> (define i 0)
> (my-or
  (begin
    (set! i (+ i 1))
    #t)
  2)
> i
We can try to solve the problem thus:

(define-macro my-or
  (lambda (x y)
    `(let ([temp ,x])
       (if temp temp ,y))))
But now what happens?

> (define temp 3)
> (my-or #f temp)
Re-implement the my-or macro, in a way that avoids this variable capture problem from using define-macro, by instead using define-syntax to invoke Scheme's built-in `hygienic' and `referentially transparent' macro system.


