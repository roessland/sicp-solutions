# SICP Exercise 1.17 and 1.18: Multiplication by repeated doubling

Design a "fast multiplication algorithm" that uses repeated addition to
multiply two integers in a logarithmic number of steps.
You may additionally use the `double` and `halve` functions.

## Answer

This answer was made for 1.17, but it turns out to be valid for 1.18 also.

With the solution of exercise 1.16 fresh in memory I will attempt to solve this
one without looking at the previous procedure for exponentiation by repeated squaring.

```scheme
(define (double n) (+ n n))
(define (halve n) (/ n 2))
(define (even? n) (= (modulo n 2) 0))

(define (fast-mul b c)
  (define (mul-iter a b c)
    (cond ((= c 0) a)
          ((even? c) (mul-iter a (double b) (halve c)))
          (else (mul-iter (+ a b) b (- c 1)))))
  (mul-iter 0 b c))
```

This runs in *log(c)* time with constant space,
and runs iteratively using tail-call optimization.
