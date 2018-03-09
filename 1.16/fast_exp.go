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