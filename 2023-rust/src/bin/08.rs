use std::collections::HashMap;

use itertools::Itertools;

advent_of_code::solution!(8);

enum Direction {
    Left,
    Right,
}

pub fn part_one(input: &str) -> Option<u32> {
    let (directions, map) = parse_input(input);
    solve_part_one("AAA", &directions, &map, |node| node == "ZZZ")
}

fn solve_part_one(
    starting_node: &str,
    directions: &[Direction],
    map: &HashMap<&str, (&str, &str)>,
    end_condition: fn(&str) -> bool,
) -> Option<u32> {
    let mut current_node = starting_node;
    let mut steps: u32 = 0;
    for direction in directions.iter().cycle() {
        if end_condition(current_node) {
            break;
        };
        steps += 1;
        let (left, right) = map.get(current_node).unwrap();
        current_node = match direction {
            Direction::Left => left,
            Direction::Right => right,
        };
    }

    Some(steps)
}

pub fn part_two(input: &str) -> Option<u64> {
    let (directions, map) = parse_input(input);

    let steps_per_ghost = map
        .keys()
        .filter(|key| key.ends_with('A'))
        .filter_map(|node| solve_part_one(node, &directions, &map, |node| node.ends_with('Z')))
        .collect_vec();

    Some(
        steps_per_ghost
            .iter()
            .map(|steps| *steps as u64)
            .fold(1, lcm),
    )
}

fn gcd(a: u64, b: u64) -> u64 {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}

fn lcm(a: u64, b: u64) -> u64 {
    a / gcd(a, b) * b
}

fn parse_input(input: &str) -> (Vec<Direction>, HashMap<&str, (&str, &str)>) {
    let mut lines = input.lines();
    let directions = parse_directions(lines.next().unwrap());
    // discard empty line
    lines.next();

    let map: HashMap<&str, (&str, &str)> = lines
        .filter_map(|line| line.split_once('='))
        .map(|(start, options)| {
            let (left, right) = options[2..options.len() - 1].split_once(',').unwrap();
            (start.trim(), (left.trim(), right.trim()))
        })
        .collect();

    (directions, map)
}

fn parse_directions(line: &str) -> Vec<Direction> {
    line.chars()
        .map(|char| match char {
            'L' => Direction::Left,
            'R' => Direction::Right,
            _ => panic!("This cannot happen"),
        })
        .collect_vec()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part_one() {
        let result = part_one(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(2));
    }

    #[test]
    fn test_part_two() {
        let result = part_two(&advent_of_code::template::read_file_part(
            "examples", DAY, 2,
        ));
        assert_eq!(result, Some(6));
    }
}
