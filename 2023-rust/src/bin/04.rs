use std::collections::VecDeque;

use itertools::Itertools;

advent_of_code::solution!(4);

#[derive(Clone)]
struct ScratchCard {
    id: u32,
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

    pub fn copies(&self) -> Vec<u32> {
        self.winning_numbers
            .iter()
            .map(|number| self.numbers.contains(number))
            .filter(|contained| *contained)
            .enumerate()
            .map(|(i, _)| self.id + i as u32 + 1)
            .collect_vec()
    }
}

pub fn part_one(input: &str) -> Option<u32> {
    parse_input(input)
        .iter()
        .map(|card| card.points())
        .reduce(|acc, points| acc + points)
}

pub fn part_two(input: &str) -> Option<u32> {
    let cards = parse_input(input);

    let lookup = cards.iter().map(|card| card.copies()).collect_vec();

    let mut queue = VecDeque::from(cards.iter().map(|card| card.id).collect::<Vec<u32>>());
    let mut total = 0;
    while let Some(id) = queue.pop_front() {
        total += 1;

        queue.extend(&lookup[id as usize]);
    }

    Some(total)
}

fn parse_input(input: &str) -> Vec<ScratchCard> {
    input
        .lines()
        .filter_map(|line| line.strip_prefix("Card"))
        .filter_map(|line| line.split_once(':'))
        .map(|(index, numbers)| {
            let (winning, mine) = numbers.split_once('|').unwrap();
            let parsed_index: u32 = index.trim().parse().unwrap();
            ScratchCard {
                id: parsed_index - 1,
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
        assert_eq!(result, Some(30));
    }
}
