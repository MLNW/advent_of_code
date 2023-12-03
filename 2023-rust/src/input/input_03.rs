use std::collections::HashMap;

use regex::Regex;

#[derive(PartialEq, Eq, Hash, Clone, Copy)]
pub struct Coordinate {
    pub x: usize,
    pub y: usize,
}

#[derive(Clone, Eq, PartialEq, Hash)]
pub struct Symbol {
    pub character: char,
    pub position: Coordinate,
}

pub struct EnginePart {
    pub number: u32,
    pub start: Coordinate,
    pub end: Coordinate,
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

pub fn parse_input(input: &str, pattern: &str) -> (Vec<EnginePart>, HashMap<Coordinate, Symbol>) {
    (parse_engine_parts(input), parse_symbols(input, pattern))
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
