package sicp111

import "testing"
import "github.com/stretchr/testify/assert"

func TestRecursiveF(t *testing.T) {
	assert.Equal(t, 0, RecursiveF(0))
	assert.Equal(t, -1, RecursiveF(-1))
	assert.Equal(t, 4, RecursiveF(3))
	assert.Equal(t, 4536349, RecursiveF(19))
}

func TestF(t *testing.T) {
	assert.Equal(t, int64(0), F(0))
	assert.Equal(t, int64(-1), F(-1))
	assert.Equal(t, int64(4), F(3))
	assert.Equal(t, int64(4536349), F(19))
	assert.Equal(t, int64(349485574054925), F(40))
	assert.Equal(t, int64(26376696606571600), F(45))
	// Panics due to integer overflow
	// assert.Equal(t, int64(1990726300381593467), F(50))
}
