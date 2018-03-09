# SICP Exercise 1.7: Iterative square root

Design a square root procedure.

## Answer

```scheme
(define (sqrt-iter prev-guess guess x)
  (if (good-enough? prev-guess guess x)
      guess
      (sqrt-iter guess (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y) (/ (+ x y) 2))

(define (square x) (* x x))

(define (good-enough? prev-guess guess x)
  (< (/ (abs (- guess prev-guess)) guess) 0.0000001))

(define (sqrt x) (sqrt-iter 0.0 1.0 x))

(sqrt 0.0000000002)
; Works great for small numbers

(sqrt 100000000000000000000000000000000.0)
; Works well for big number

(define bob 43766787327326894343232394309304380308391212121238693627.214783783)
(- bob (sqrt (* bob bob)))
; Fails hard for huge number

(define jon 5734895443324738947382.0343411)
(- jon (sqrt (* jon jon)))
; Works great for reasonably big number
```