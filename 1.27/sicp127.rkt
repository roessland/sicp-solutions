#lang sicp

(define (square n) (* n n))

(define (even? n) (= 0 (remainder n 2)))

(define (expmod base exp m)
  (cond [(= 0 exp) 1]
        [(even? exp) (remainder
                      (square (expmod base (/ exp 2) m))
                      m)]
        [else (remainder
               (* base (expmod base (- exp 1) m))
               m)]))

(define (carmichael? n)
  (define (car-iter a)
    (cond [(= a n) true]
          [else (and  (= a (expmod a n n)) (car-iter (+ a 1)))]))
  (car-iter 1))

(define (test n info)
  (display n)
  (display " ")
  (display (carmichael? n))
  (display " ")
  (display info)
  (display "\n"))

(test 561  "composite and carmichael")
(test 1105 "composite and carmichael")
(test 1729 "composite and carmichael")
(test 2465 "composite and carmichael")
(test 2821 "composite and carmichael")
(test 2821 "composite and carmichael")
(test 6659 "prime")
(test 6603 "composite")
(test 6601 "composite and carmichael")
(test 15883 "composite")
