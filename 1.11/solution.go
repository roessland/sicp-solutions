package sicp1_11

func RecursiveF(n int) int {
	if n < 3 {
		return n
	}
	return RecursiveF(n-1) + 2*RecursiveF(n-2) + 3*RecursiveF(n-3)
}

func F(n int) int64 {
	if n < 3 {
		return int64(n)
	}
	a, b, c := int64(0), int64(1), int64(2)
	for numRemaining := n; numRemaining > 0; numRemaining-- {
		a, b, c = b, c, c+2*b+3*a
		if c < b || c < a {
			panic("Integer overflow")
		}
	}
	return a
}