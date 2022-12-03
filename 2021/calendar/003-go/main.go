package main

import (
	"advent-of-code-2021/utils/files"
	"fmt"
	"strconv"
)

func parseInput(lines []string) [][2]int {
	var counters [][2]int
	for i, line := range lines {
		for j, char := range line {
			if i == 0 {
				counters = append(counters, [2]int{0, 0})
			}
			if char == '0' {
				counters[j][0]++
			} else {
				counters[j][1]++
			}
		}
	}
	return counters
}

func calcPowerConsumption(counters [][2]int) int64 {
	var gammaRate string
	var epsilonRate string
	for _, counter := range counters {
		if counter[0] > counter[1] {
			gammaRate = gammaRate + "0"
			epsilonRate = epsilonRate + "1"
		} else {
			gammaRate = gammaRate + "1"
			epsilonRate = epsilonRate + "0"
		}
	}
	gamma := convertBinToDec(gammaRate)
	epsilon := convertBinToDec(epsilonRate)
	return gamma * epsilon
}

func calcLifeSupportRating(lines []string, counters [][2]int) int64 {
	var oxygenGenerator string
	var co2Scrubber string

	for i, line := range lines {
		if i > 0 {
			// calc new counters
		}

	}

	oxygen := convertBinToDec(oxygenGenerator)
	co2 := convertBinToDec(co2Scrubber)
	return oxygen * co2
}

func convertBinToDec(bin string) int64 {
	dec, err := strconv.ParseInt(bin, 2, 64)
	if err != nil {
		panic(err)
	}
	return dec
}

func main() {
	lines := files.ReadLines("input.txt")
	counters := parseInput(lines)
	for _, counter := range counters {
		fmt.Printf("[%d, %d]", counter[0], counter[1])
	}
	fmt.Println()
	power := calcPowerConsumption(counters)
	fmt.Println(power)
	lifeSupport := calcLifeSupportRating(lines, counters)
	fmt.Println(lifeSupport)
}
