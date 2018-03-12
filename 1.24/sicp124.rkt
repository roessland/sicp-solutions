#lang sicp

(define (square n) (* n n))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 10000) ; switch between prime? and fast-prime? here
      (report-prime (- (runtime) 
                       start-time))))
                       
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

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

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (big-random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (big-random n)
  (remainder(+
             (* 2147483648 (random 2147483648))
             (random 2147483648))
            n))

(timed-prime-test 100000000003)
(timed-prime-test 100000000019)
(timed-prime-test 100000000057)
(timed-prime-test 100000000007); not prime
(timed-prime-test 1000000000039)
(timed-prime-test 1000000000061)
(timed-prime-test 1000000000063)
(timed-prime-test 1000000000067); not prime
(timed-prime-test 10000000000037)
(timed-prime-test 10000000000051)
(timed-prime-test 10000000000099)
(timed-prime-test 10000000000199); not prime
(timed-prime-test 100000000000031)
(timed-prime-test 100000000000067)
(timed-prime-test 100000000000097)
(timed-prime-test 100000000000101); not prime


(timed-prime-test 113)
(timed-prime-test 1013)
(timed-prime-test 10009)
(timed-prime-test 100019)
(timed-prime-test 1000037)
(timed-prime-test 10000019)
(timed-prime-test 100000049)
(timed-prime-test 1000000033)
(timed-prime-test 10000000061)
(timed-prime-test 100000000069)
(timed-prime-test 1000000000063)
(timed-prime-test 10000000000129)
(timed-prime-test 100000000000099)
(timed-prime-test 1000000000000223)
(timed-prime-test 2305843009213693951); mersenne prime 2^61-1