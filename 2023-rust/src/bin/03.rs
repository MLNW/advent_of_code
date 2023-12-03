use std::collections::HashMap;

use regex::Regex;

advent_of_code::solution!(3);

#[derive(PartialEq, Eq, Hash, Clone, Copy)]
struct Coordinate {
    x: usize,
    y: usize,
}

#[derive(Clone, Eq, PartialEq, Hash)]
struct Symbol {
    character: char,
    position: Coordinate,
}

struct EnginePart {
    number: u32,
    start: Coordinate,
    end: Coordinate,
}

impl EnginePart {
    fn neighbors(&self) -> Vec<Coordinate> {
        let mut neighbors: Vec<Coordinate> = Vec::new();

        let y = self.start.y;
        for x in self.start.x..self.end.x + 1 {
            // left
            if x > 0 && x == self.start.x {
                neighbors.push(Coordinate { x: x - 1, y });
                neighbors.push(Coordinate { x: x - 1, y: y + 1 });
                if y > 0 {
                    neighbors.push(Coordinate { x: x - 1, y: y - 1 });
                }
            }
            // right
            if x == self.end.x {
                neighbors.push(Coordinate { x: x + 1, y });
                neighbors.push(Coordinate { x: x + 1, y: y + 1 });
                if y > 0 {
                    neighbors.push(Coordinate { x: x + 1, y: y - 1 });
                }
            }
            //top
            if y > 0 {
                neighbors.push(Coordinate { x, y: y - 1 });
            }
            //bottom
            neighbors.push(Coordinate { x, y: y + 1 });
        }

        neighbors
    }

    pub fn neighboring_symbol(&self, symbols: &HashMap<Coordinate, Symbol>) -> Option<Symbol> {
        for neighbor in self.neighbors() {
            if let Some(symbol) = symbols.get(&neighbor) {
                return Some(symbol.clone());
            }
        }
        None
    }
}

pub fn part_one(input: &str) -> Option<u32> {
    let parts = parse_engine_parts(input);
    let symbols: HashMap<Coordinate, Symbol> = parse_symbols(input, r"(\+|-|\*|/|=|\$|@|%|#|&)");

    parts
        .iter()
        .filter(|part| part.neighboring_symbol(&symbols).is_some())
        .map(|part| part.number)
        .reduce(|acc, number| acc + number)
}

pub fn part_two(input: &str) -> Option<u32> {
    let parts = parse_engine_parts(input);
    let symbols: HashMap<Coordinate, Symbol> = parse_symbols(input, r"\*");

    parts
        .iter()
        .map(|part| (part.neighboring_symbol(&symbols), part))
        .filter_map(|(symbol, part)| symbol.map(|s| (s, part)))
        // Group by neighboring symbol
        .fold(
            HashMap::new(),
            |mut acc: HashMap<Symbol, Vec<&EnginePart>>, (symbol, part)| {
                acc.entry(symbol).or_default().push(part);
                acc
            },
        )
        .iter()
        .filter_map(|(_, parts)| {
            if parts.len() == 2 {
                return Some(parts);
            }
            None
        })
        // Calculate gear ratio
        .map(|parts| {
            parts
                .iter()
                .map(|part| part.number)
                .reduce(|acc, number| acc * number)
                .unwrap()
        })
        .reduce(|acc, gear_ratio| acc + gear_ratio)
}

fn parse_engine_parts(input: &str) -> Vec<EnginePart> {
    let mut parts: Vec<EnginePart> = Vec::new();
    let regex = Regex::new(r"\d+").unwrap();
    for (y, line) in input.lines().enumerate() {
        for number_match in regex.find_iter(line) {
            parts.push(EnginePart {
                number: number_match.as_str().parse().unwrap(),
                start: Coordinate {
                    x: number_match.start(),
                    y,
                },
                end: Coordinate {
                    x: number_match.end() - 1,
                    y,
                },
            })
        }
    }
    parts
}

fn parse_symbols(input: &str, pattern: &str) -> HashMap<Coordinate, Symbol> {
    let mut symbols: HashMap<Coordinate, Symbol> = HashMap::new();
    let regex = Regex::new(pattern).unwrap();
    for (y, line) in input.lines().enumerate() {
        for symbol_match in regex.find_iter(line) {
            let position = Coordinate {
                x: symbol_match.start(),
                y,
            };
            symbols.insert(
                position,
                Symbol {
                    character: symbol_match.as_str().chars().next().unwrap(),
                    position,
                },
            );
        }
    }
    symbols
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part_one() {
        let result = part_one(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(4361));
    }

    #[test]
    fn test_part_two() {
        let result = part_two(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(467835));
    }
}
