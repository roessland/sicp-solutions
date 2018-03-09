# SICP Exercise 1.8: Cube root


## Answer

Using same strategy as 1.7.

```scheme
(define (cbrt-iter prev-guess guess x)
  (if (good-enough? prev-guess guess x)
      guess
      (cbrt-iter guess (improve guess x) x)))

(define (improve y x)
  (/ (+ (/ x (* y y)) (* 2 y)) 3.0))

(define (cube x) (* x x x))

(define (good-enough? prev-guess guess x)
  (< (/ (abs (- guess prev-guess)) guess) 0.0000000000001))

(define (cbrt x) (cbrt-iter 0.5 1.0 x))

(define (test x) (cbrt (* x x x)))
(test 5)
(test 0.5)
(test 0.0000005)
(test 0.000000000000005)
(test 0.000000000000000000000000000000000000005)
(test 125)
(test 9999999999999995000999)
(test 0.012345678910111213141516)
```

All tests pass with good precision.