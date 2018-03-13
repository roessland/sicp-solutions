#lang sicp

(define (even? n) (= 0 (remainder n 2)))

(define (square n) (* n n))

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

(expmod 43433543 54435251 323); Less than 0.5 seconds
;(slow-expmod 43433543 54435251 323); 12 seconds