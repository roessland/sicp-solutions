# SICP Exercise 1.16

Design a procedure that evolves an iterative exponentiation
process that uses success squaring and uses a logarithmic 
number of steps.

## Answer

```scheme

#lang sicp

(define (even? n) (= (modulo n 2) 0))

(define (square n) (* n n))

(define (fast-expt b n)
  (define (expt-iter a b n)
    (cond
      ((= n 0) a)
      ((even? n) (expt-iter a (square b) (/ n 2)))
      (else (expt-iter (* a b) b (- n 1)))))
  (expt-iter 1 b n))
```

The idea here is to use the facts that e.g. 
$2^{10} = (2^2)^5$
and
$2^{11} = 2\cdot 2^{10}$.

The exponentiation of 2 is reduced to the exponentiation of 4 which is again
reduced to the exponentiation of 16 and so on.

To keep the procedure iterative (make it possible for the interpreter to use tail-call optimization) we must introduce a third function parameter *a*,
which will store the cumulative result.

The loop invariant $ab^n$ stays constant throughout every iteration.
SICP mentions that invariants like this are a powerful method
for designing iterative procedures.

### Example: Computing 2^10

    (fast-expt 2 10)
        (expt-iter 1 2 10);    1*2^10 = 1024
            (expt-iter 1 4 5);    1*4^5 = 1024
                (expt-iter 4 4 4);    4*4^4 = 1024
                    (expt-iter 4 16 2);    4*16^2 = 1024
                        (expt-iter 4 256 1);    4 * 256^1 = 1024
                            (expt-iter 1024 256 0);    1024*256^0 = 1024
                                1024

Notice that *a* only changes when *n* is odd,
but stays constant while *n* is even.
Every procedure call itself directly or returns the answer,
so the process is iterative, and doesn't require traversing back up
the call stack again.

## Solution in Go

Algorithm adapted from my Scheme code above.
I think this is much uglier than the Scheme version and harder to understand,
even the function is just a few lines.

```go
// fast_exp.go
package sicp116

// Exp computes exponent of b to the power n using successive squaring
func Exp(b, n int64) int64 {
	a := int64(1)
	for n > 0 {
		if n % 2 == 0 {
			b, n = b*b, n/2
		} else {
			a, n = a*b, n-1
		}
	}
	return a
}
```

```go
// fast_exp_test.go
package sicp116

import "testing"

import "github.com/stretchr/testify/assert"

func TestExp(t *testing.T) {
	assert.Equal(t, int64(1), Exp(1337, 0))
	assert.Equal(t, int64(50), Exp(50, 1))
	assert.Equal(t, int64(129140163), Exp(3, 17))
}
```