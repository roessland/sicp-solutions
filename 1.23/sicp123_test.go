package sicp123

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
