# SICP Exercise 1.22: Timed prime search

The following `timed-prime-test` procedure,
when called with an integer *n*, prints
*n* and checks to see if *n* is prime.
If *n* is prime, the procedure prints three asterisks followed
by the amount of time used in performing the test.

```scheme
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) 
                       start-time))))
                       
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))
```

Using this procedure,
write a procedure `search-for-primes` that
checks the primality of consecutive odd integers in
a specified range.
Use your procedure to find the three smallest primes
larger than 1000; larger than 10,000; larger than 100,000;
larger than 1,000,000. 
Note the time needed to test each prime.
Since the testing algorithm has order of growth Θ(n),
you should expect that testing for primes around 10,000 should take
about 10 times as long as testing for primes around 1000.
Do your timing results data bear this out?
How well do the data for 100,000 and 1,000,000 support the Θ(n) prediction.
Is your result compatible with the notion that programs on your machine run
in time proportional to the number of steps required for the computation?

## Answer
The following procedure applies the prime test for a range of numbers.

```scheme
(define (search-for-primes a b)
  (cond ((even? a) (search-for-primes (+ a 1) b))
        ((< a b) (timed-prime-test a) (search-for-primes (+ a 2) b))
        (else "done")))
```

The most interesting part for a new Schemer like me is the expression
`((< a b) (timed-prime-test a) (search-for-primes (+ a 2) b))`.
How can `cond` return two variables? What's going on here?

Reading the [Racket manual on conditionals](https://docs.racket-lang.org/reference/if.html)
we see that the then-expression within conditionals are allowed
to have multiple expressions.
All of them are evaluated but only the final expression is returned,
meaning `(timed-prime-test a)` is evaluated but not returned.
We get to see the side effects (displaying info) from this procedure,
but never its return value (it doesn't seem to have one).

Example of this from my Racket REPL:

```scheme
> (cond (true (display (runtime)) "foo") (else (display "yo") "bar"))
1520695296658976"foo"
> (cond (false (display (runtime)) "foo") (else (display "yo") "bar"))
yo"bar"
> (cond (false (display (runtime)) "foo") (else "ignored" (display "yo") "bar"))
yo"bar"
```

It's not visible here, but in the REPL the returned strings "foo" and "bar" have
a different color than the rest of the output.
This is because these are the actual returned values,
while the rest is just a side effect from `display`.

Enough distractions, back the the exercise.

```scheme
; From Exercise 1.21
(define (square n) (* n n))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b) (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

; From Exercise 1.22 description
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) 
                       start-time))))
                       
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

; My answer to Exercise 1.22
(define (even? n) (= 0 (remainder n 2)))

(define (next n) (if (even? n) (+ n 1) (+ n 2)))

(define (search-for-primes a b)
  (cond ((< a b) (timed-prime-test a) (search-for-primes (next a) b))
        (else "done")))

(search-for-primes 100 120)
(search-for-primes 1000 1020)
(search-for-primes 10000 10040)
(search-for-primes 100000 100050)
(search-for-primes 1000000 1000050)
(search-for-primes 10000000 10000050)
(search-for-primes 100000000 100000050)
(search-for-primes 1000000000 1000000050)
(search-for-primes 10000000000 10000000070)
(search-for-primes 100000000000 100000000070)
(search-for-primes 1000000000000 1000000000070)
(search-for-primes 10000000000000 10000000000130)
(search-for-primes 100000000000000 100000000000130)
```

Run this to get the output below.
To verify the time complexity I had to bump the numbers
a bit since SICP is showing it's age.

**Time spent to prime test a single prime number of given size:** 
(Non-primes are much faster to test since the test fails quickly.)
```
100: 0μs
1000: 0μs
10000: 0μs
100000: 0μs
1000000: 500μs
10000000: 1000μs
100000000: 2500μs
1000000000: 8500μs
10000000000: 26000μs
100000000000: 90000μs
1000000000000: 270000μs
10000000000000: 900000μs
100000000000000: 2700000μs
```

**Complexity:**
This is clearly not linear.
I suspect the radical brackets for square roots have disappeard in my
copy of the book,
and that the complexity should be O(sqrt(n)).

```
    n	         t	        n/t	    sqrt(n)/t
    1.00E+06	500	    2.00E+03	2
    1.00E+07	1000	1.00E+04	3.16227766
    1.00E+08	2500	4.00E+04	4
    1.00E+09	8500	1.18E+05	3.720326659
    1.00E+10	26000	3.85E+05	3.846153846
    1.00E+11	90000	1.11E+06	3.513641845
    1.00E+12	270000	3.70E+06	3.703703704
    1.00E+13	900000	1.11E+07	3.513641845
    1.00E+14	2700000	3.70E+07	3.703703704
```

The trusty Excel-method of complexity analysis confirms
that the procedure is indeed O(sqrt(n)) as expected.


## Prime search output

`***` means prime. The number after `***` is the number of microseconds spent
to verify that the number in the first column was prime.

List of 12 primes to be used for the next exercise (1.23):

```
100000000003 *** 26506
100000000019 *** 26007
100000000057 *** 25505
1000000000039 *** 83521
1000000000061 *** 84020
1000000000063 *** 136032
10000000000037 *** 259565
10000000000051 *** 304075
10000000000099 *** 298092
100000000000031 *** 911062
100000000000067 *** 895226
100000000000097 *** 891485
```

All tested numbers:

```
101 *** 501
103 *** 0
105
107 *** 0
109 *** 0
111
113 *** 0
115
117
119"done"

1001
1003
1005
1007
1009 *** 0
1011
1013 *** 0
1015
1017
1019 *** 0"done"

10001
10003
10005
10007 *** 0
10009 *** 0
10011
...
10035
10037 *** 0
10039 *** 0"done"

100001
100003 *** 0
100005
100007
100009
100011
100013
100015
100017
100019 *** 0
100021
...
100041
100043 *** 0
100045
100047
100049 *** 0"done"

1000001
1000003 *** 0
1000005
...
1000031
1000033 *** 0
1000035
1000037 *** 0
1000039 *** 0
1000041
1000043
1000045
1000047
1000049"done"

10000001
...
10000017
10000019 *** 0
10000021
...
10000047
10000049"done"

100000001
100000003
100000005
100000007 *** 500
100000009
...
100000035
100000037 *** 1000
100000039 *** 500
100000041
100000043
100000045
100000047
100000049 *** 1000"done"

1000000001
1000000003
1000000005
1000000007 *** 2501
1000000009 *** 2501
1000000011
1000000013
1000000015
1000000017
1000000019
1000000021 *** 2499
1000000023
1000000025
1000000027
1000000029
1000000031
1000000033 *** 2500
1000000035
...
1000000047
1000000049"done"

10000000001
10000000003
...
10000000017
10000000019 *** 8503
10000000021
...
10000000031
10000000033 *** 8000
10000000035
...
10000000059
10000000061 *** 8504
10000000063
10000000065
10000000067
10000000069 *** 8501"done"

100000000001
100000000003 *** 26506
100000000005
...
100000000017
100000000019 *** 26007
100000000021
...
100000000055
100000000057 *** 25505
100000000059
100000000061
100000000063 *** 25508
100000000065
100000000067
100000000069 *** 26001"done"

1000000000001
1000000000003
...
1000000000037
1000000000039 *** 83521
1000000000041
...
1000000000059
1000000000061 *** 84020
1000000000063 *** 136032
1000000000065
1000000000067
1000000000069"done"

10000000000001
10000000000003
...
10000000000035
10000000000037 *** 259565
10000000000039
...
10000000000049
10000000000051 *** 304075
10000000000053
...
10000000000097
10000000000099 *** 298092
10000000000101
...
10000000000127
10000000000129 *** 276112"done"

...
100000000000029
100000000000031 *** 911062
100000000000033
...
100000000000065
100000000000067 *** 895226
100000000000069
...
100000000000095
100000000000097 *** 891485
100000000000099 *** 911499
100000000000101
...
100000000000127
100000000000129"done"
```

## Answer in Go

Not much exciting here, but it's worth noting that Go is 10
times faster than the DrRacket REPL for this exercise.

`(timed-prime-test 10000000000000099)`: 8.3 seconds

`IsPrime(10000000000000099):` 0.9 seconds


**sicp122.go**

```go
package sicp122

import (
	"fmt"
	"time"
)

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

// IsPrime checks for primality
func IsPrime(n int64) bool {
	return n == SmallestDivisor(n)
}

// TimedPrimeTest prints candidate,  and includes time spent if it was prime.
func TimedPrimeTest(n int64) {
	start := time.Now()
	isPrime := IsPrime(n)
	end := time.Now()
	elapsed := end.Sub(start)
	if isPrime {
		fmt.Printf("%d *** %d\n", n, elapsed.Nanoseconds()/1000)
	} else {
		fmt.Println(n)
	}
}

// SearchForPrimes tests a range of numbers for primality,
// printing all candidates to standard output.
// Primes found are annotated with the time spent in microseconds.
func SearchForPrimes(a, b int64) {
	next := func(n int64) int64 {
		if n%2 == 0 {
			return n + 1
		}
		return n + 2
	}
	for n := a; n < b; n = next(n) {
		TimedPrimeTest(n)
	}
}
```

**sicp122_test.go**

```go
package sicp122

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestSmallestDivisor(t *testing.T) {
	assert.Equal(t, int64(2), SmallestDivisor(1000))
}

func TestIsPrime(t *testing.T) {
	assert.Equal(t, false, IsPrime(1000))
}

func TestSearchForPrimes(t *testing.T) {
	for n := int64(1); n < 100000000000000000; n *= 10 {
		SearchForPrimes(n, n+100)
	}
}

```