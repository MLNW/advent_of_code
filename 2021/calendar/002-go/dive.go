package main

import (
	"advent-of-code-2021/utils/files"
	"fmt"
	"log"
	"strconv"
	"strings"
)

func parseInput(lines []string) []Command {
	var commands []Command
	for _, line := range lines {
		parts := strings.Fields(line)
		instruction := ParseInstruction(parts[0])
		value, err := strconv.Atoi(parts[1])
		if err != nil {
			log.Fatalf("Failed to parse number from: %s", line)
		}
		commands = append(commands, Command{Instruction: instruction, Value: value})
	}
	return commands
}

func solve(commands []Command) int {
	position := 0
	depth := 0

	for _, command := range commands {
		switch command.Instruction {
		case Forward:
			position += command.Value
		case Down:
			depth += command.Value
		case Up:
			depth -= command.Value
		}
	}

	return position * depth
}

func solveAim(commands []Command) int {
	aim := 0
	position := 0
	depth := 0
	for _, command := range commands {
		switch command.Instruction {
		case Forward:
			position += command.Value
			depth += aim * command.Value
		case Down:
			aim += command.Value
		case Up:
			aim -= command.Value
		}
	}
	return position * depth
}

func main() {
	lines := files.ReadLines("input.txt")
	commands := parseInput(lines)

	var solution int = solve(commands)
	fmt.Printf("The solution is %d\n", solution)

	solution = solveAim(commands)
	fmt.Printf("The aim solution is %d\n", solution)
}
