# SICP Exercise 1.26: Slow fast-prime procedure

Explain why using explicit multiplication in the `expmod` procedure
instead of `square`
transforms the runtime from O(log(n)) to O(n).

## Fast
```scheme
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder 
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder 
          (* base 
             (expmod base (- exp 1) m))
          m))))
```

## Slow

```scheme
(define (slow-expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder 
          (* (slow-expmod base (/ exp 2) m)
             (slow-expmod base (/ exp 2) m))
          m))
        (else
         (remainder 
          (* base 
             (slow-expmod base (- exp 1) m))
          m))))
```

## Answer

If you have read CLRS, this should be familiar.

For the fast method, we recurse down until `exp` is zero,
halving the argument for almost every step,
creating one new process for every recursion.
There will be a approximately log2(n) recursions.

For `exp=18`, `expmod` is called with the following exponents:
```
18 -> 9 -> 8 -> 4 -> 2 -> 1 -> 0
```

For the slow method,
`expmod` is called recursively **twice** within the procedure body.
This will create a binary tree-ish structure of processes.

Each number below is the exponent of the procedure being called.
```
  18
  9 + 9
  8 + 8
  4 + 4 + 4 + 4
  2 + 2 + 2 + 2 + 2 + 2 + 2 + 2
  1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1
  0 + 0 + 0 + 0 + 0 + 0 + 0 + 0 + 0 + 0 + 0 + 0
```

The total number of nodes in such a tree is approximately equal to
`1 + 2 + 4 + 8 + 18`.

This is a finite finite series that converges to approximately `2n`,
which is O(n).