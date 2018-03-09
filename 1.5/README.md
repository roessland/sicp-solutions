# SICP Exercise 1.5: Applicative vs normal-order evaluation

Ben Bitdiddle has invented a test to determine
whether the interpreter he is faced with is using applicative order
evaluation or normal-order evaluation. He defines the
following two procedures:

    (define (p) (p))
    (define (test x y)
        (if (= x 0) 0 y))

Then he evaluates the expression

    (test 0 (p))

What behavior will Ben observe with an interpreter that
uses applicative-order evaluation? What behavior will he
observe with an interpreter that uses normal-order evaluation?
Explain your answer. 
(Assume that the evaluation rule for the special form if is the same whether the interpreter is using normal or applicative order: The predicate
expression is evaluated first, and the result determines
whether to evaluate the consequent or the alternative expression.)

## Answer

**Applicative-order evaluation**

My guess for what happens:

    (test 0 (p))
    (test 0 (p))
    (test 0 (p))
    (test 0 (p))
    (test 0 (p))
    (test 0 (p))
    ...
    recursion limit reached or memory exhausted

What actually happened: Program kept running, no output.
Looks like my hypothesis was correct.

**Normal order evaluation**

    (test 0 (p))
    (if (= 0 0) 0 (p))
    0

Well defined since we never need to evaluate (p). Lazy evaluation.