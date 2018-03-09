# SICP Exercise 1.2: Prefix form

Translate the following expression into prefix form:

    5 + 5 + (2 - (3 - (6 - 4/5)))
    -----------------------------
    3(6 - 2)(2 - 7)

Answer:

    (/ (+ 5
        5
        (- 2
            (- 3 (- 6 (/ 4 5)))))
    (* 3
        (- 6 2)
        (- 2 7)))

Wolfram alpha gives

    (5 + 5 + (2 - (3 - (6 - 4/5))))/(3(6 - 2)(2 - 7)) = -71/300

and Racket gives -71/300, so the expression is correct.


