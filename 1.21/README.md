# SICP Exercise 1.12: Smallest divisor of 199, 1999 and 19999

Use the `smallest-divisor` procedure to find the smallest divisor of each
of the following numbers: 199, 1999, 19999



## Answer

Copying the procedure by hand into my editor and adding
the missing definition and evaluations:

```scheme
(define (square n) (* n n))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b) (= (remainder b a) 0))

(smallest-divisor 199)
(smallest-divisor 1999)
(smallest-divisor 19999)
```

Output:

```
199
1999
7
```

We see that 199 and 1999 are prime while 19999 is divisible by seven.
And indeed, 19999 = 7*2857.

## Answer in Go

Iterative version of the above.
It does look more ugly than the Scheme code,
especially due to the infinite loop.

```go
package sicp121

// SmallestDivisor returns the smallest divisor of n
func SmallestDivisor(n int64) int64 {
	var divisor int64 = 2
	for {
		if divisor*divisor > n {
			return n
		} else if n%divisor == 0 {
			return divisor
		} else {
			divisor++
		}
	}
}
```

Tests

```go
package sicp121

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestSmallestDivisor(t *testing.T) {
	assert.Equal(t, int64(1), SmallestDivisor(1))
	assert.Equal(t, int64(2), SmallestDivisor(2))
	assert.Equal(t, int64(199), SmallestDivisor(199))
	assert.Equal(t, int64(1999), SmallestDivisor(1999))
	assert.Equal(t, int64(7), SmallestDivisor(19999))
}
```