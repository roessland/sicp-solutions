#lang sicp

; Exercise 1.3: Define a procedure that takes three numbers
; as arguments and returns the sum of the squares of the two
; larger numbers.
(define (squareSumLargest a b c)
  (cond ((<= a (min b c)) (sumSquares b c))
        ((<= b (min a c)) (sumSquares a c))
        (else (sumSquares a b))))
              
(define (min a b) (if (< a b) a b))

(define (sumSquares a b) (+ (square a) (square b)))

(define (square x) (* x x))


; tests
(define (assert pred msg) (if (not pred) (error msg)))

(assert (= 13 (squareSumLargest 1 2 3)) "1 2 3 failed")
(assert (= 25 (squareSumLargest 4 2 3)) "4 2 3 failed")
(assert (= 41 (squareSumLargest 4 5 3)) "3 5 3 failed")