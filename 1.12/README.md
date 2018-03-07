# SICP Exercise 1.12

The following pattern of numbers is called Pascal’s triangle. 

                1
              1   1
            1   2   1
          1   3   3   1
        1   4   6   4   1
              . . .

The numbers at the edge of the triangle are all 1, and each number inside the triangle is the sum of the two numbers above it. 
Write a procedure that computes elements of Pascal’s triangle by means of a recursive process.

## Answer

Straight forward recursion without error handling.

    (define (pascal row col)
        (cond ((= col 0) 1)
                ((= col row) 1)
                (else (+ (pascal (- row 1) (- col 1)) (pascal (- row 1) col)))))

Quick verification:

    (pascal 0 0)
    ; 1
    (pascal 1 0) (pascal 1 1)
    ; 1 1
    (pascal 2 0) (pascal 2 1) (pascal 2 2)
    ; 1 2 1
    (pascal 3 0) (pascal 3 1) (pascal 3 2) (pascal 3 3)
    ; 1 3 3 1

    (= 6435 (pascal 15 7))
    ; true

The recursive solution is very slow however, using several seconds to compute `(pascal 30 15)`.
I suspect that I will need to learn some more advanced Scheme functionality (lists) to be
able to solve this in an iterative fashion.

As a side note `(pascal m n)` is equal to the binomial coefficient ${ m \choose n }$.

## Answer in Go

The Go solution is mostly the same. No surprises here. It looks better due to the binary operator notation.

    // solution.go
    package sicp112

    // Pascal computes the number at a given zero-indexed position in Pascal's pyramid.
    func Pascal(row, col int) int64 {
        if col == 0 || col == row {
            return 1
        }
        return Pascal(row-1, col-1) + Pascal(row-1, col)
    }


    // solution_test.go
    package sicp112

    import "testing"

    import "github.com/stretchr/testify/assert"

    func TestPascal(t *testing.T) {
        assert.Equal(t, int64(1), Pascal(0, 0))

        assert.Equal(t, int64(1), Pascal(1, 0))
        assert.Equal(t, int64(1), Pascal(1, 1))

        assert.Equal(t, int64(1), Pascal(2, 0))
        assert.Equal(t, int64(2), Pascal(2, 1))
        assert.Equal(t, int64(1), Pascal(2, 2))

        assert.Equal(t, int64(252), Pascal(10, 5))
    }

For an iterative Go solution, [see my gopkg/mathutil repository on GitHub](https://github.com/roessland/gopkg/blob/master/mathutil/binomial.go).
The iterative version is pretty fast (you can't go much faster than this
without involving FFT/convolutions), and is the one I use for Project Euler problems.