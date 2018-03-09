package sicp119

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestFib(t *testing.T) {
	assert.Equal(t, int64(0), Fib(0))
	assert.Equal(t, int64(1), Fib(1))
	assert.Equal(t, int64(1), Fib(2))
	assert.Equal(t, int64(2), Fib(3))
	assert.Equal(t, int64(3), Fib(4))
	assert.Equal(t, int64(5), Fib(5))
	assert.Equal(t, int64(8), Fib(6))
	assert.Equal(t, int64(13), Fib(7))
	assert.Equal(t, int64(21), Fib(8))
	assert.Equal(t, int64(34), Fib(9))
	assert.Equal(t, int64(55), Fib(10))
	assert.Equal(t, int64(89), Fib(11))
	assert.Equal(t, int64(144), Fib(12))
}
