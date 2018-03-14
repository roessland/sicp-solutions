# SICP Exercise 1.27

Demonstrate that the Carmichael numbers listed below really do fool the Fermat test.
That is,
write a procedure that takes an integer *n* and tests whether
`a^n^ is congruent to *a* modulo *n* for every *a* < *n*,
and try your procedure on the given Carmichael numbers.

* 561
* 1105
* 1729
* 2465
* 2821
* 6601

## Answer

Just loop through all possible bases in the Fermat test using iteration.
I'm using the `and` special form to short-circuit failures.

Note that `carmichael?` isn't 100% correct -- it will return true for
prime numbers, even though Carmichael numbers are composite by definition.

```scheme
#lang sicp

(define (square n) (* n n))

(define (even? n) (= 0 (remainder n 2)))

(define (expmod base exp m)
  (cond [(= 0 exp) 1]
        [(even? exp) (remainder
                      (square (expmod base (/ exp 2) m))
                      m)]
        [else (remainder
               (* base (expmod base (- exp 1) m))
               m)]))

(define (carmichael? n)
  (define (car-iter a)
    (cond [(= a n) true]
          [else (and  (= a (expmod a n n)) (car-iter (+ a 1)))]))
  (car-iter 1))

(define (test n info)
  (display n)
  (display " ")
  (display (carmichael? n))
  (display " ")
  (display info)
  (display "\n"))

(test 561  "composite and carmichael")
(test 1105 "composite and carmichael")
(test 1729 "composite and carmichael")
(test 2465 "composite and carmichael")
(test 2821 "composite and carmichael")
(test 2821 "composite and carmichael")
(test 6659 "prime")
(test 6603 "composite")
(test 6601 "composite and carmichael")
(test 15883 "composite")
```

### Output

```
561 #t composite and carmichael
1105 #t composite and carmichael
1729 #t composite and carmichael
2465 #t composite and carmichael
2821 #t composite and carmichael
2821 #t composite and carmichael
6659 #t prime
6603 #f composite
6601 #t composite and carmichael
15883 #f composite
```