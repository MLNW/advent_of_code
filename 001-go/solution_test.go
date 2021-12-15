package main

import (
	"testing"
)

func TestSolution(t *testing.T) {
	numbers := []int{199, 200, 208, 210, 200, 207, 240, 269, 260, 263}

	solution := solve(numbers)
	if solution != 7 {
		t.Fatalf("The solution should have been 7 but is: %d", solution)
	}
}

func TestSlidingSolution(t *testing.T) {
	numbers := []int{199, 200, 208, 210, 200, 207, 240, 269, 260, 263}

	solution := solve_sliding(numbers)

	if solution != 5 {
		t.Fatalf("The solution should have been 5 but is: %d", solution)
	}
}
