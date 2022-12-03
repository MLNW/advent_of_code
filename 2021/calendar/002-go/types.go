package main

import (
	"fmt"
	"log"
)

type Instruction int64

const (
	Forward Instruction = iota
	Down
	Up
)

func ParseInstruction(str string) Instruction {
	switch str {
	case "forward":
		return Forward
	case "down":
		return Down
	case "up":
		return Up
	}
	log.Fatalf("Unknown instruction: %s\n", str)
	return Forward
}

func (s Instruction) String() string {
	switch s {
	case Forward:
		return "forward"
	case Down:
		return "down"
	case Up:
		return "up"
	}
	return "unknown"
}

type Command struct {
	Instruction Instruction
	Value       int
}

func (cmd Command) String() string {
	return fmt.Sprintf("Command{'%s', %d}", cmd.Instruction, cmd.Value)
}
