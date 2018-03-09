package sicp116

import "testing"

import "github.com/stretchr/testify/assert"

func TestExp(t *testing.T) {
	assert.Equal(t, int64(1), Exp(1337, 0))
	assert.Equal(t, int64(50), Exp(50, 1))
	assert.Equal(t, int64(129140163), Exp(3, 17))
}