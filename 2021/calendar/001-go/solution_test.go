package main

import (
	"testing"
)

var input = []string{
	"199", "200", "208", "210", "200",
	"207", "240", "269", "260", "263",
}
var numbers = []int{199, 200, 208, 210, 200, 207, 240, 269, 260, 263}

func TestParseInput(t *testing.T) {
	result := parseInput(input)

	for i := 0; i < len(input); i++ {
		if result[i] != numbers[i] {
			t.Logf("Expected %d, but got %d", numbers[i], result[i])
			t.Fail()
		}
	}
}

func TestSolution(t *testing.T) {
	result := solve(numbers)

	expected := 7
	if result != expected {
		t.Fatalf("The solution should have been %d but is: %d", expected, result)
	}
}

func TestSlidingSolution(t *testing.T) {
	result := solve_sliding(numbers)

	expected := 5
	if result != expected {
		t.Fatalf("The solution should have been %d but is: %d", expected, result)
	}
}
