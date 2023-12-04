use itertools::Itertools;

advent_of_code::solution!(4);

struct ScratchCard {
    index: u32,
    winning_numbers: Vec<u32>,
    numbers: Vec<u32>,
}

impl ScratchCard {
    pub fn points(&self) -> u32 {
        let fold = self
            .winning_numbers
            .iter()
            .map(|number| self.numbers.contains(number))
            .filter(|contained| *contained)
            .fold(1, |acc, _| acc * 2);
        fold / 2
    }
}

pub fn part_one(input: &str) -> Option<u32> {
    parse_input(input)
        .iter()
        .map(|card| card.points())
        .reduce(|acc, points| acc + points)
}

pub fn part_two(input: &str) -> Option<u32> {
    None
}

fn parse_input(input: &str) -> Vec<ScratchCard> {
    input
        .lines()
        .filter_map(|line| line.strip_prefix("Card"))
        .filter_map(|line| line.split_once(':'))
        .map(|(index, numbers)| {
            let (winning, mine) = numbers.split_once('|').unwrap();
            ScratchCard {
                index: index.trim().parse().unwrap(),
                winning_numbers: parse_numbers(winning),
                numbers: parse_numbers(mine),
            }
        })
        .collect_vec()
}

fn parse_numbers(numbers: &str) -> Vec<u32> {
    numbers
        .split_whitespace()
        .map(|number| number.parse().unwrap())
        .collect_vec()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part_one() {
        let result = part_one(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(13));
    }

    #[test]
    fn test_part_two() {
        let result = part_two(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, None);
    }
}
