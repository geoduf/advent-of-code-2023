package adventofcode1

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPar1(t *testing.T) {
	sum := calculatePart1()
	assert.Equal(t, 54304, sum)
}

func TestPar2(t *testing.T) {
	sum := calculatePart2()
	assert.Equal(t, 54418, sum)
}
