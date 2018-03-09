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
