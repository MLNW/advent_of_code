package main

import (
	"testing"
)

func TestSolution(t *testing.T) {
	commands := []Command{
		Command{Instruction: Forward, Value: 5},
		Command{Instruction: Down, Value: 5},
		Command{Instruction: Forward, Value: 8},
		Command{Instruction: Up, Value: 3},
		Command{Instruction: Down, Value: 8},
		Command{Instruction: Forward, Value: 2},
	}

	solution := solve(commands)

	if solution != 150 {
		t.Fatalf("The solution should have been 150 but is: %d", solution)
	}
}

func TestAimSolution(t *testing.T) {
	commands := []Command{
		Command{Instruction: Forward, Value: 5},
		Command{Instruction: Down, Value: 5},
		Command{Instruction: Forward, Value: 8},
		Command{Instruction: Up, Value: 3},
		Command{Instruction: Down, Value: 8},
		Command{Instruction: Forward, Value: 2},
	}

	solution := solveAim(commands)

	if solution != 900 {
		t.Fatalf("The solution should have been 900 but is: %d", solution)
	}
}
