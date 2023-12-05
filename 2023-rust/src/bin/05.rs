use std::{
    collections::{HashMap, VecDeque},
    time::SystemTime,
};

use itertools::Itertools;
use rayon::iter::{IntoParallelIterator, ParallelIterator};

advent_of_code::solution!(5);

#[derive(PartialEq, Eq, Hash)]
struct RangeKey {
    start: u64,
    end: u64,
}

#[derive(Clone, Copy)]
struct MapEntry {
    source: u64,
    destination: u64,
}

impl MapEntry {
    fn map(&self, input: &u64) -> u64 {
        self.destination + (input - self.source)
    }
}

pub fn part_one(input: &str) -> Option<u64> {
    let (seeds, maps) = parse_input(input);

    solve_part_one(seeds, &maps)
}

fn solve_part_one(seeds: Vec<u64>, maps: &Vec<HashMap<RangeKey, MapEntry>>) -> Option<u64> {
    seeds
        .iter()
        .map(|seed| {
            let mut value = *seed;
            for map in maps {
                let entry = find_map_entry(map, value);
                value = match entry {
                    Some(entry) => entry.map(&value),
                    None => value,
                }
            }
            value
        })
        .min()
}

pub fn part_two(input: &str) -> Option<u64> {
    let (seeds, maps) = parse_input(input);

    let max_seed_range_length = 10_000_000;
    let mut seed_ranges: Vec<(u64, u64)> = Vec::new();
    for mut chunk in &seeds.iter().chunks(2) {
        let mut start = *chunk.next().unwrap();
        let length = *chunk.next().unwrap();
        let stop = start + length;

        loop {
            if start + max_seed_range_length < stop {
                seed_ranges.push((start, start + max_seed_range_length));
                start += max_seed_range_length;
            } else {
                seed_ranges.push((start, stop));
                break;
            }
        }
    }

    seed_ranges
        .into_par_iter()
        .filter_map(|(start, stop)| {
            let timer = SystemTime::now();
            let current_seeds = (start..stop).collect_vec();
            let result = solve_part_one(current_seeds, &maps);
            println!(
                "[{start}-{stop}] in {:?} => {:?}",
                timer.elapsed().unwrap(),
                result
            );
            result
        })
        .min()
}

fn find_map_entry(map: &HashMap<RangeKey, MapEntry>, value: u64) -> Option<MapEntry> {
    map.iter()
        .find(|(key, _)| value >= key.start && value <= key.end)
        .map(|(_, &map)| map)
}

fn parse_input(input: &str) -> (Vec<u64>, Vec<HashMap<RangeKey, MapEntry>>) {
    let mut groups: VecDeque<&str> = input.split("\n\n").collect();

    let seeds = parse_seeds(groups.pop_front().unwrap());

    let maps = groups.iter().map(|map| parse_map(map)).collect_vec();

    (seeds, maps)
}

fn parse_seeds(line: &str) -> Vec<u64> {
    line.strip_prefix("seeds: ")
        .unwrap()
        .split_whitespace()
        .map(|number| number.parse().unwrap())
        .collect_vec()
}

fn parse_map(input: &str) -> HashMap<RangeKey, MapEntry> {
    let mut lines = input.lines();
    lines.next();

    lines
        .map(|line| line.split_whitespace())
        .map(|split| {
            split
                .map(|number| number.parse().unwrap())
                .collect_tuple()
                .unwrap()
        })
        .map(|(destination, source, range)| {
            (
                RangeKey {
                    start: source,
                    end: source + range - 1,
                },
                MapEntry {
                    source,
                    destination,
                },
            )
        })
        .collect()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part_one() {
        let result = part_one(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(35));
    }

    #[test]
    fn test_part_two() {
        let result = part_two(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(46));
    }
}
