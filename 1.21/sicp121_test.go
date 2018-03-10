package sicp121

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestSmallestDivisor(t *testing.T) {
	assert.Equal(t, int64(1), SmallestDivisor(1))
	assert.Equal(t, int64(2), SmallestDivisor(2))
	assert.Equal(t, int64(199), SmallestDivisor(199))
	assert.Equal(t, int64(1999), SmallestDivisor(1999))
	assert.Equal(t, int64(7), SmallestDivisor(19999))
}
