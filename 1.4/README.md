# SICP Exercise 1.4: Higher order functions

Observe that our model of evaluation allows
for combinations whose operators are compound expressions.
Use this observation to describe the behavior of the
following procedure:

    (define (a-plus-abs-b a b)
       ((if (> b 0) + -) a b))

## Answer:

If b > 0, the expression evaluates to

    (+ a b) = a + |b|

otherwise it evaluates to

    (- a b) = a + |b| (for negative b)

So (a-plus-abs-b a b) is equal to a + |b| as one would expect.