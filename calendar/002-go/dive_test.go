package main

import (
	"testing"
)

var lines = []string{
	"forward 5",
	"down 5",
	"forward 8",
	"up 3",
	"down 8",
	"forward 2",
}

var commands = []Command{
	{Instruction: Forward, Value: 5},
	{Instruction: Down, Value: 5},
	{Instruction: Forward, Value: 8},
	{Instruction: Up, Value: 3},
	{Instruction: Down, Value: 8},
	{Instruction: Forward, Value: 2},
}

func TestParseInput(t *testing.T) {
	result := parseInput(lines)

	for i := 0; i < len(lines); i++ {
		if result[i] != commands[i] {
			t.Logf("Expected %s, but got %s", commands[i], result[i])
			t.Fail()
		}
	}
}

func TestSolution(t *testing.T) {
	result := solve(commands)

	expected := 150
	if result != expected {
		t.Fatalf("The solution should have been %d but is: %d", expected, result)
	}
}

func TestAimSolution(t *testing.T) {
	result := solveAim(commands)

	expected := 900
	if result != expected {
		t.Fatalf("The solution should have been %d but is: %d", expected, result)
	}
}
