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

## Answers in Go

The recursive method is just as straight forward as in Scheme.

	// solution.go
	package sicp111

	func RecursiveF(n int) int {
		if n < 3 {
			return n
		}
		return RecursiveF(n-1) + 2*RecursiveF(n-2) + 3*RecursiveF(n-3)
	}

In my opinion the iterative version looks better than the Scheme version 
(though that may change as I get through more chapters of SICP).
I have avoided calling any functions recursively, and instead opted
for a for-loop. This is because Go doesn't have tail-call optimization like Scheme does.
I used `int64` instead of arbitrary precision integers for simplicity,
but added a small overflow check that catches som errors.

	func F(n int) int64 {
		if n < 3 {
			return int64(n)
		}
		a, b, c := int64(0), int64(1), int64(2)
		for numRemaining := n; numRemaining > 0; numRemaining-- {
			a, b, c = b, c, c+2*b+3*a
			if c < b || c < a {
				panic("Integer overflow")
			}
		}
		return a
	}

## Test cases for Go answers

	// solution_test.go
	package sicp111

	import "testing"
	import "github.com/stretchr/testify/assert"

	func TestRecursiveF(t *testing.T) {
		assert.Equal(t, 0, RecursiveF(0))
		assert.Equal(t, -1, RecursiveF(-1))
		assert.Equal(t, 4, RecursiveF(3))
		assert.Equal(t, 4536349, RecursiveF(19))
	}

	func TestF(t *testing.T) {
		assert.Equal(t, int64(0), F(0))
		assert.Equal(t, int64(-1), F(-1))
		assert.Equal(t, int64(4), F(3))
		assert.Equal(t, int64(4536349), F(19))
		assert.Equal(t, int64(349485574054925), F(40))
		assert.Equal(t, int64(26376696606571600), F(45))
		// Panics due to integer overflow
		// assert.Equal(t, int64(1990726300381593467), F(50))
	}
