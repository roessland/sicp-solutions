# SICP Exercise 1.19: Fast Fibonacci by squaring the linear operator T

Let $(T p q)$ be the linear operator such that
$(T p q)(a, b) \rightarrow (bq + aq + ap, bp + aq)$.

Let $T$ be a special case of $(T p q)$ where $p=0$ and $q=1$,
meaning _T(a, b) = (b + a, a)_.

**a)** Observe that applying $T$ to $(1,0)$ $n$ times
produces the pair _Fib(n+1)_ and _Fib(n)_.

**b)** Show that _(T p q)(T p q)_ is equivalent to _(T p' q')_ for some _p'_ and _q'_.
Compute _p'_ and _q'_ in terms of _p_ and _q_.

**c)** Since the transformation can be squared,
we can use repeated squaring to compute _T^n_.
Complete the following procedure:

```scheme
(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) 
         b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* p p) (* q q))  ;compute p'
                   (+ (* 2 p q) (* q q))  ;compute q'
                   (/ count 2)))
        (else 
         (fib-iter (+ (* b q) 
                      (* a q) 
                      (* a p))
                   (+ (* b p) 
                      (* a q))
                   p
                   q
                   (- count 1)))))
```

## Answers

**a)**

```
T(a, b) = (b+a, a)
T(1, 0) = (1, 1)
T(1, 1) = (2, 1)
T(2, 1) = (3, 2)
T(3, 2) = (5, 3)
T(5, 3) = (8, 5)
```

We see that the evaluation of T is uses the exact same process
we use to compute the Fibonacci series.

**b)**
```
(T p q)(a, b) = (bq + aq + ap, bp + aq)
(T p q)(bq + aq + ap, bp + aq) = (
    [bp + aq]q + [bq + aq + ap]q + [bq + aq + ap]p, 
    [bp + aq]p + [bq + aq + ap]q
)
```

Expand expression and gather a, b terms.

```
(T p q)(qb + qa + pa, pb + qa) = (
    bpq + aqq + bqq + aqq + apq + bpq + apq + app, 
    bpp + apq + bqq + aqq + apq
)
= (
    (pq +qq + pq)b + (qq +  qq + pq +  pq + pp)a,
    (pp + qq)b + (pq +  qq + pq)a
)
```

We want to find `p', q'` such that `(T p q)(T p q) = (T p' q')`.

```
I: (pq + qq + pq)b + (qq +  qq + pq +  pq + pp)a = q'b + q'a + p'a
II: (pp + qq)b + (pq +  qq + pq)a = p'b + q'a
```

So we must have

```
I: pq + qq + pq = q'
II: qq +  qq + pq +  pq + pp = q' + p'
III: pp + qq = p'
IV: pq +  qq + pq = q'

Quick verification:
II-IV: qq  + pp = p'
```

Meaning `p' = p^2 + q^2` and `q' = 2pq + q^2`.

**c)**

Just insert `p'` and `q'` into the given code to get:

```scheme
(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) 
         b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* p p) (* q q))    ;compute p'
                   (+ (* 2 p q) (* q q))  ;compute q'
                   (/ count 2)))
        (else 
         (fib-iter (+ (* b q) 
                      (* a q) 
                      (* a p))
                   (+ (* b p) 
                      (* a q))
                   p
                   q
                   (- count 1)))))
```

Some tests.

```
(= 1 (fib 1))     ;true
(= 1 (fib 2))     ;true
(= 2 (fib 3))     ;true
(= 3 (fib 4))     ;true
(= 144 (fib 12))  ;true
```

## Answer in Go
Straight-forward port of the Scheme code.

```go
// fib.go
package sicp119

// Fib returns the nth Fibonacci number
func Fib(n int) int64 {
	var a, b, p, q int64
	a, b, p, q = 1, 0, 0, 1
	for n > 0 {
		if n%2 == 0 {
			p, q, n = p*p+q*q, 2*p*q+q*q, n/2
		} else {
			a, b, n = b*q+a*q+a*p, b*p+a*q, n-1
		}
	}
	return b
}


// fib_test.go
package sicp119

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestFib(t *testing.T) {
	assert.Equal(t, int64(0), Fib(0))
	assert.Equal(t, int64(1), Fib(1))
	assert.Equal(t, int64(1), Fib(2))
	assert.Equal(t, int64(2), Fib(3))
	assert.Equal(t, int64(3), Fib(4))
	assert.Equal(t, int64(5), Fib(5))
	assert.Equal(t, int64(8), Fib(6))
	assert.Equal(t, int64(13), Fib(7))
	assert.Equal(t, int64(21), Fib(8))
	assert.Equal(t, int64(34), Fib(9))
	assert.Equal(t, int64(55), Fib(10))
	assert.Equal(t, int64(89), Fib(11))
	assert.Equal(t, int64(144), Fib(12))
}
```