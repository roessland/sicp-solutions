#lang sicp

(define (pascal row col)
  (cond ((= col 0) 1)
        ((= col row) 1)
        (else (+ (pascal (- row 1) (- col 1)) (pascal (- row 1) col)))))

(pascal 0 0)
(pascal 1 0) (pascal 1 1)
(pascal 2 0) (pascal 2 1) (pascal 2 2)
(pascal 3 0) (pascal 3 1) (pascal 3 2) (pascal 3 3)

; tests
(= 6435 (pascal 15 7))