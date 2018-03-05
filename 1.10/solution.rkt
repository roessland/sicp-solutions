#lang sicp

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1) (A x (- y 1))))))

(A 1 10)
(A 2 4)
(A 3 3)

;

(A 0 1)
(A 0 2)
(A 0 3)
(A 0 4)
(A 0 5)
(A 0 6)
; (A 0 n) = 2*n

(A 1 1)
(A 1 2)
(A 1 3)
(A 1 4)
(A 1 5)
(A 1 6)
; (A 1 n) = 2^n

(A 2 1); 2
(A 2 2); 4
(A 2 3); 16
(A 2 4); 65536
;(A 2 5) ;huge number
