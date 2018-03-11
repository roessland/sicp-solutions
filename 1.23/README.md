# SICP Exercise 1.23: Prime finding improvements

The `smallest-divisor` procedure used in **Exercise 1.22** does
lots of needless testing, 
by attempting to use even numbers as test divisors.
Implement a `next` procedure that returns the next
test divisor, skipping even numbers (except 2).

Run the timed prime test on the 12 primes found in the previous exercise.

## Answer

The 12 primes from the previous exercise are:

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

The numbers after *** is the time spent in microseconds to go 
through the test divisors from 2 to sqrt(n).

Change `find-divisor` to use the `next` instead of `+ 1` to get the following

```scheme
(define (find-divisor n test-divisor)
  (define (next d) (if (= 2 d) 3 (+ d 2)))
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))
```

And add the primes to be tested:

```scheme
(timed-prime-test 100000000003)
(timed-prime-test 100000000019)
(timed-prime-test 100000000057)
(timed-prime-test 1000000000039)
(timed-prime-test 1000000000061)
(timed-prime-test 1000000000063)
(timed-prime-test 10000000000037)
(timed-prime-test 10000000000051)
(timed-prime-test 10000000000099)
(timed-prime-test 100000000000031)
(timed-prime-test 100000000000067)
(timed-prime-test 100000000000097)
```

Output:

```
100000000003 *** 18505
100000000019 *** 16503
100000000057 *** 16504
1000000000039 *** 53041
1000000000061 *** 55014
1000000000063 *** 51553
10000000000037 *** 166564
10000000000051 *** 174043
10000000000099 *** 167042
100000000000031 *** 533193
100000000000067 *** 533333
100000000000097 *** 536347
```

Before comparing the timings, 
let's predict the improvement:

**Before:** sqrt(n)

**After:** 1/2 * sqrt(n)

**Ratio:** 0.5

And going back to the old trusty Excel method for complexity analysis we see that this
is only approximately true.
I'm guessing the extra time is spent evaluating the `next` procedure.

```
Before	After	After/Before
26506	18505	0.698143816
26007	16503	0.634559926
25505	16504	0.647088806
83521	53041	0.635061841
84020	55014	0.654772673
136032	51553	0.378977005
259565	166564	0.64170439
304075	174043	0.572368659
298092	167042	0.560370624
911062	533193	0.585243375
895226	533333	0.595752358
891485	536347	0.60163323
```

## Complete code

```scheme
(define (square n) (* n n))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (define (next d) (if (= 2 d) 3 (+ d 2)))
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (divides? a b) (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

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

(timed-prime-test 100000000003)
(timed-prime-test 100000000019)
(timed-prime-test 100000000057)
(timed-prime-test 1000000000039)
(timed-prime-test 1000000000061)
(timed-prime-test 1000000000063)
(timed-prime-test 10000000000037)
(timed-prime-test 10000000000051)
(timed-prime-test 10000000000099)
(timed-prime-test 100000000000031)
(timed-prime-test 100000000000067)
(timed-prime-test 100000000000097)
```

## Answer in Go

Add the next method to the existing code from `1.22`, like this:

```go
func nextTestDivisor(d int64) int64 {
	if d == 2 {
		return 3
	}
	return d + 2
}

// SmallestDivisor returns the smallest divisor of n
func SmallestDivisor(n int64) int64 {
	var divisor int64 = 2
	for {
		if divisor*divisor > n {
			return n
		} else if n%divisor == 0 {
			return divisor
		} else {
			divisor = nextTestDivisor(divisor)
		}
	}
}
```

Time spent before:

10000000000000099 *** 925770 microseconds

Time spent after:

10000000000000099 *** 505124 microseconds

Ratio: 0.54
