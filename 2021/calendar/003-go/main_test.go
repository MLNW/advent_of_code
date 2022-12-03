package main

import (
	"testing"
)

var lines = []string{
	"00100",
	"11110",
	"10110",
	"10111",
	"10101",
	"01111",
	"00111",
	"11100",
	"10000",
	"11001",
	"00010",
	"01010",
}

var counters = [][2]int{
	{5, 7}, {7, 5}, {4, 8}, {5, 7}, {7, 5},
}

func TestParseInput(t *testing.T) {
	result := parseInput(lines)

	for i := 0; i < len(counters); i++ {
		if result[i] != counters[i] {
			t.Logf("Expected [%d,%d], but got [%d,%d]",
				counters[i][0], counters[i][1],
				result[i][0], result[i][1])
			t.Fail()
		}
	}
}

func TestSolution(t *testing.T) {
	result := calcPowerConsumption(counters)

	expected := 198
	if result != int64(expected) {
		t.Fatalf("Expected %d, but got %d", expected, result)
	}
}

func TestLifeSupportSolution(t *testing.T) {
	result := calcLifeSupportRating(lines, counters)

	expected := 230
	if result != int64(expected) {
		t.Fatalf("Expected %d, but got %d", expected, result)
	}
}
