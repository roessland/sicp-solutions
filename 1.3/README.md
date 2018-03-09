# SICP Exercise 1.3: Sum of squares

Define a procedure that takes three numbers
as arguments and returns the sum of the squares of the two
larger numbers.

## Answer

I chose to do this using a conditional,
but there is also a method that subtracts the minimum square
from the sum of all squares.

```scheme
(define (squareSumLargest a b c)
  (cond ((<= a (min b c)) (sumSquares b c))
        ((<= b (min a c)) (sumSquares a c))
        (else (sumSquares a b))))
              
(define (min a b) (if (< a b) a b))

(define (sumSquares a b) (+ (square a) (square b)))

(define (square x) (* x x))
```

Note that `square` is defined *after* `sumSquares`,
but the interpreter doesn't complain,
meaning we are allowed to use undefined components in definitions.
I assume that is something I will learn more about later in the book.

### Tests

```scheme
(define (assert pred msg) (if (not pred) (error msg)))

(assert (= 13 (squareSumLargest 1 2 3)) "1 2 3 failed")
(assert (= 25 (squareSumLargest 4 2 3)) "4 2 3 failed")
(assert (= 41 (squareSumLargest 4 5 3)) "3 5 3 failed")
```

## Answer in Go

Straight forward implementation of the same algorithm.

```go
package sicp103

func SquareSumLargest(a, b, c int64) int64 {
	if a < b && a < c {
		return SumSquares(b, c)
	} else if b < a && b < c {
		return SumSquares(a, c)
	} else {
		return SumSquares(a, b)
	}
}

func SumSquares(a, b int64) int64 {
	return a*a + b*b
}
```

### Tests in Go

You will see me importing *testify* in almost every Go program I write,
and is because the built-in testing API is a bit too barebones for my tastes.

```go
package sicp103

import "testing"

import "github.com/stretchr/testify/assert"

func TestSquareSumLargest(t *testing.T) {
	assert.Equal(t, int64(13), SquareSumLargest(1, 2, 3))
	assert.Equal(t, int64(25), SquareSumLargest(4, 2, 3))
	assert.Equal(t, int64(41), SquareSumLargest(4, 5, 3))
}
```