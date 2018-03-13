# SICP Exercise 1.25: Non-fast modular exponentation

Alyssa P. Hacker complains that we went to a lot of extra work in writing `expmod`. After all, she says, since we already know how to compute exponentials, we could have simply written

```scheme
(define (expmod base exp m)
    (remainder (fast-expt base exp) m))
```

Is she correct? Would this procedure serve as well for our fast prime tester? Explain.

## Fast expmod from exercise 1.24

```scheme
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder
          (* base (expmod base (- exp 1) m))
          m))))
```

## Answer

The number of multiplications is the same in both `fast-expmod` and `slow-expmod`, and one could guess that the runtime would be the same.
However, that only holds if we assume the multiplications take the same amount of time.

As I briefly touched upon in Exercise 1.24,
number operations in Scheme become slower the bigger the numbers are.

Let's choose some random computation to compute using both methods:
```5444430^432444 mod 2543```.

According to Wolfram Alpha this number has the staggering amount of 2912922 digits,
represented in memory using around `10^7 bits = 1.25 MB`.

It is obvious to me that a computation using such large numbers would be slower than one using much smaller numbers,
since we are forced to use big integers instead of CPU-friendly number types such as int64.

## Code for this problem

```scheme
(define (even? n) (= (modulo n 2) 0))

(define (square n) (* n n))

(define (fast-expt b n)
  (define (expt-iter a b n)
    (cond
      ((= n 0) a)
      ((even? n) (expt-iter a (square b) (/ n 2)))
      (else (expt-iter (* a b) b (- n 1)))))
  (expt-iter 1 b n))

(define (slow-expmod base exp m)
  (remainder (fast-expt base exp) m))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder
          (* base (expmod base (- exp 1) m))
          m))))

(define t0 (runtime))
(expmod 5444430 432444 2543)
(- (runtime) t0)
""
(define tslow0 (runtime))
(slow-expmod 5444430 432444 2543)
(- (runtime) tslow0)
```

```
1710
500; timing microseconds for the fast expmod
""
1710
896000; timing microseconds for the slow expmod
```