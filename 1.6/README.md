# SICP Exercise 1.6: Special forms -- if vs new-if

    (define (new-if predicate then-clause else-clause)
      (cond (predicate then-clause)
            (else else-clause)))

    (define (sqrt-iter guess x)
      (new-if (good-enough? guess x)
               guess
              (sqrt-iter (improve guess x) x)))
          
What happens when Alyssa attempts to use this to compute square roots? Explain

## Answer

             guess  x
    (sqrt-iter 2.0 2.0)
    
    (new-if (good-enough? 2.0 2.0)
            2.0
            (sqrt-iter (improve guess 2.0) x))

    (new-if true
            2.0
            (sqrt-iter (improve guess 2.0) x))

At this point, sqrt-iter will recursive forever to the applicative evaluation.

The built-in if is apparently special since it only evaluates the correct branch.

