# SICP Exercise 1.20: Normal-order evaluation of GCD

Consider the following iterative GCD
procedure:

```scheme
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))
```

How many `remainder` operations are performed
when when using applicative-order evaluation to compute `(gcd 206 40)`?

And how many for normal-order evaluation?

## Answer

Remember that applicative order evaluation is the default in Scheme, and evaluates any subexpressions
before evaluating a rule.
(There are exceptions to this called "special forms",
which do not necessarily evaluate all arguments,
like `if` and `cond`).

Normal-order evaluation is "lazy", and evaluates
subexpressions only when needed, and applies
substitution rules with entire 
expressions as arguments before,
instead of just numbers.
This can cause expressions to be evaluated multiple times
unnecessarily, like in this exercise.

### Applicative-order evaluation

Applicative order is much easier to wrap your head around.

```
(gcd 206 40)
    (gcd 40 6) ; computed (remainder 206 40)
        (gcd 6 4) ; computed (remainder 40 6)
            (gcd 4 2) ; computed (remainder 6 4)
                (gcd 2 0) ; computed (remainder 4 2)
                    2
```

### Normal-order evaluation

While normal-order evaluation can be quite confusing...
At first I ended up with the same number as above (4),
and had to do some Googling to check my answer.
Armed with the knowledge that the answer was 18 and not 4 I managed
to compute it in the following way:

The algorithm I used is:

1. Do substitution according to the definition of `(gcd a b)`.
   Keep in mind that you should not evaluate `a` and `b` before doing the substitution --
   that would be applicative-order evaluation.

2. Evaluate the predicate argument for the `if` special-form.

3. Repeat 1. and 2. until you are left with a simple expression without any if-expressions.

```
(gcd 206 40)

(if (= 40 0) 206 (gcd 40 (remainder 206 40)))

; evaluate 40


(gcd 40 (remainder 206 40))

(if (= (remainder 206 40) 0) 40 (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))

; evaluate (remainder 206 40) = 6, evals+1


(gcd (remainder 206 40) (remainder 40 (remainder 206 40)))

(if (= (remainder 40 (remainder 206 40)) 0) (remainder 206 40) (gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))

; evaluate (remainder 40 (remainder 206 40)) = 4, evals+2


(gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))

(if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0) (remainder 40 (remainder 206 40)) (gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))))

; evaluate (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) = 2, evals+4


(gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))

(if (= (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 0) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (gcd (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) (remainder (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))

; evaluate (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) = 0, evals+7


(remainder (remainder 206 40) (remainder 40 (remainder 206 40)))

; evaluate the above = 2, evals+4

2
```

Tally up the "evals+n" in the comments above to get a total of 18 evaluations.
14 evaluations were needed for the if special form evaluations,
and 4 evaluations were needed to reduce the final expression.

All in all this exercise gave me a much better understanding of normal-order evaluation
that I hadn't quite grasped in the previous exercise on evaluation.

In this exercise the applicative-order evaluation was much more efficient.
But is that always true? And when is normal-order evaluation better?
Food for thought.