package sicp123

import (
	"fmt"
	"time"
)

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
