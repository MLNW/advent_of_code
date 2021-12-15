package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

func readInput(file os.File) ([]Command, error) {
	var commands []Command
	scanner := bufio.NewScanner(&file)
	for scanner.Scan() {
		line := scanner.Text()
		parts := strings.Fields(line)
		instruction := ParseInstruction(parts[0])
		value, err := strconv.Atoi(parts[1])
		if err != nil {
			log.Fatalf("Failed to parse number from: %s", line)
		}
		commands = append(commands, Command{Instruction: instruction, Value: value})
	}
	return commands, scanner.Err()
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
	file, err := os.Open("input.txt")
	if err != nil {
		log.Fatalf("Failed to open file!")
	}
	defer file.Close()

	commands, err := readInput(*file)
	if err != nil {
		log.Fatalf("Failed to read file!")
	}

	var solution int = solve(commands)
	fmt.Printf("The solution is %d\n", solution)

	solution = solveAim(commands)
	fmt.Printf("The aim solution is %d\n", solution)
}
