# SICP Exercise 1.1

Exercise 1.1: Below is a sequence of expressions. What is the result printed by the interpreter in response to each expression? Assume that the sequence is to be evaluated in the order in which it is presented.

    #lang sicp
    10
    ; 10 = 10

    (+ 5 3 4)
    ; 5 + 3 + 4 = 12

    (- 9 1)
    ; 9 - 1 = 8

    (/ 6 2)
    ; 6 / 2 = 3

    (+ (* 2 4) (- 4 6))
    ; 8 + (-2) = 6

    (define a 3)
    ; nothing? yup

    (define b (+ a 1))
    ; nothing? yup

    (+ a b (* a b))
    ; a+a+1+a*(a+1) = 3a+1+a^2 = 9+1+9=19? yup

    (= a b)
    ; (= a (+ a 1)) = false?
    ; almost, interpreter gives #f which I assume == false

    (if (and (> b a) (< b (* a b)))
        b
        a)
    ; if (true and true) = b = a+1 = 4 

    (cond ((= a 4) 6)
        ((= b 4) (+ 6 7 a))
        (else 25))
    ; 6 + 7 + 3 = 16

    (+ 2 (if (> b a) b a))
    ; 6

    (* (cond ((> a b) a)
            ((< a b) b)
            (else -1))
       (+ a 1))
    ; b * (a+1) = 4*4 = 16