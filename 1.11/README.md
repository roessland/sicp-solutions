# SICP Exercise 1.11

A function *f* is defined by the rule that

	(n<3)  f(n) = n
	(n>=3) f(n) = f(n-1) + 2*f(n-2) +3*f(n-3)

Write a procedure that computes *f* by means of a recursive process.
Write a procedure that computes *f* by means of an iterative process.

## Answer: Recursive

Writing the function definition out in a straight forward way,
we get the following function:

	(define (f n)
	(if (< n 3)
		n
		(+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))))

It is clearly a very inefficient method to calculate *f*, as it
takes several seconds to complete f(29).

## Answer: Iterative

The idea here is to start from (0, 1, 2), and then
compute the next number as many times as needed.

	(define (f-iter n)
		(define (next a b c) (+ c (* 2 b) (* 3 a)))
		(define (g remaining-steps a b c)
			(if (= remaining-steps 0)
				a
				(g (- remaining-steps 1) b c (next a b c))))
		(if (< n 3)
			n
			(g n 0 1 2)))

I'm not entirely happy with the final if-section since I believe it could be
removed somehow, but at least it works.

The iterative version's performance is exponentially faster, computing e.g. `(f-iter 24347)` instantly.

For an iterative version that goes down from n to 0 as opposed to my version, see [the Scheme Wiki](http://community.schemewiki.org/?sicp-ex-1.11).