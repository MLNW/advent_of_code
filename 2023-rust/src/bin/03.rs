use std::collections::HashMap;

use advent_of_code::input::input_03::{parse_input, EnginePart, Symbol};

advent_of_code::solution!(3);

pub fn part_one(input: &str) -> Option<u32> {
    let (parts, symbols) = parse_input(input, r"(\+|-|\*|/|=|\$|@|%|#|&)");

    parts
        .iter()
        .filter_map(|part| part.neighboring_symbol(&symbols).map(|_| part.number))
        .reduce(|acc, number| acc + number)
}

pub fn part_two(input: &str) -> Option<u32> {
    let (parts, symbols) = parse_input(input, r"\*");

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
