package sicp112

// Pascal computes the number at a given zero-indexed position in Pascal's pyramid.
func Pascal(row, col int) int64 {
	if col == 0 || col == row {
		return 1
	}
	return Pascal(row-1, col-1) + Pascal(row-1, col)
}
