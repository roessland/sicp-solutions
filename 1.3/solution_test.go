package sicp103

import "testing"

import "github.com/stretchr/testify/assert"

func TestSquareSumLargest(t *testing.T) {
	assert.Equal(t, int64(13), SquareSumLargest(1, 2, 3))
	assert.Equal(t, int64(25), SquareSumLargest(4, 2, 3))
	assert.Equal(t, int64(41), SquareSumLargest(4, 5, 3))
}
