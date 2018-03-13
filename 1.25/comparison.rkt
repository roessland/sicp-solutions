#lang sicp

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

