package sicp1_3

/*
Exercise 1.3: Define a procedure that takes three numbers
as arguments and returns the sum of the squares of the two
larger numbers.
*/

func SquareSumLargest(a, b, c int64) int64 {
	if a < b && a < c {
		return SumSquares(b, c)
	} else if b < a && b < c {
		return SumSquares(a, c)
	} else {
		return SumSquares(a, b)
	}
}

func SumSquares(a, b int64) int64 {
	return a*a + b*b
}