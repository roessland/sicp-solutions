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
