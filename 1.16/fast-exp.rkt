#lang sicp

(define (even? n) (= (modulo n 2) 0))

(define (square n) (* n n))

(define (fast-exp-recur b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-exp-recur b (/ n 2))))
        (else (* b (fast-exp-recur b (- n 1))))))

(= 129140163 (fast-exp-recur 3 17))

(define (fast-expt b n)
  (define (expt-iter a b n)
    (cond
      ((= n 0) a)
      ((even? n) (expt-iter a (square b) (/ n 2)))
      (else (expt-iter (* a b) b (- n 1)))))
  (expt-iter 1 b n))

(= 129140163 (fast-expt 3 17))