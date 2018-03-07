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
