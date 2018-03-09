#lang sicp

(define (double n) (+ n n))
(define (halve n) (/ n 2))
(define (even? n) (= (modulo n 2) 0))

(define (fast-mul b c)
  (define (mul-iter a b c)
    (cond ((= c 0) a)
          ((even? c) (mul-iter a (double b) (halve c)))
          (else (mul-iter (+ a b) b (- c 1)))))
  (mul-iter 0 b c))

(fast-mul 5 10)
(= 56154 (fast-mul 42 1337))