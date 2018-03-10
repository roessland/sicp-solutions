#lang sicp

; From Exercise 1.21
(define (square n) (* n n))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b) (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

; From Exercise 1.22 description
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) 
                       start-time))))
                       
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

; My answer to Exercise 1.22
(define (even? n) (= 0 (remainder n 2)))

(define (next n) (if (even? n) (+ n 1) (+ n 2)))

(define (search-for-primes a b)
  (cond ((< a b) (timed-prime-test a) (search-for-primes (next a) b))
        (else "done")))

(search-for-primes 100 120)
(search-for-primes 1000 1020)
(search-for-primes 10000 10040)
(search-for-primes 100000 100050)
(search-for-primes 1000000 1000050)
(search-for-primes 10000000 10000070)
(search-for-primes 100000000 100000070)
(search-for-primes 1000000000 1000000070)
(search-for-primes 10000000000 10000000070)
(search-for-primes 100000000000 100000000070)
(search-for-primes 1000000000000 1000000000070)
(search-for-primes 10000000000000 10000000000130)
(search-for-primes 100000000000000 100000000000130)
(search-for-primes 1000000000000000 1000000000000230)