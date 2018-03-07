#lang sicp

(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))))

(define (f-iter n)
  (define (next a b c) (+ c (* 2 b) (* 3 a)))
  (define (g remaining-steps a b c)
    (if (= remaining-steps 0)
        a
        (g (- remaining-steps 1) b c (next a b c))))
  (if (< n 3)
      n
      (g n 0 1 2)))

(f 0)
(f-iter 0)

(f 1)
(f-iter 1)

(f 2)
(f-iter 2)

(f 3)
(f-iter 3)

(f 4)
(f-iter 4)

(f-iter 24347)

(f-iter -5)

(f -5)