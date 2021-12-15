package main

import "log"

type Instruction int64

const (
	Forward Instruction = iota
	Down
	Up
)

type Command struct {
	Instruction Instruction
	Value       int
}

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
