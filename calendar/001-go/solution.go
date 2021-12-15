package main

import (
	"advent-of-code-2021/utils/files"
	"fmt"
	"log"
	"strconv"
)

func parseInput(lines []string) []int {
	var numbers []int
	for _, line := range lines {
		number, err := strconv.Atoi(line)
		if err != nil {
			log.Fatalf("Failed to parse number from: %s", line)
		}
		numbers = append(numbers, number)
	}
	return numbers
}

func solve(numbers []int) int {
	last := numbers[0]
	increases := 0
	for _, x := range numbers[1:] {
		if x > last {
			increases++
		}
		last = x
	}
	return increases
}

func sum(numbers []int) int {
	sum := 0
	for _, x := range numbers {
		sum += x
	}
	return sum
}

func solve_sliding(numbers []int) int {
	increases := 0
	for i := 0; i < len(numbers)-3; i++ {
		first_window := numbers[i : i+3]
		second_window := numbers[i+1 : i+4]

		if sum(second_window) > sum(first_window) {
			increases++
		}
	}
	return increases
}

func main() {
	lines := files.ReadLines("input.txt")
	numbers := parseInput(lines)

	solution := solve(numbers)
	fmt.Printf("The solution is %d\n", solution)

	sliding_solution := solve_sliding(numbers)
	fmt.Printf("The sliding solution is %d\n", sliding_solution)
}
