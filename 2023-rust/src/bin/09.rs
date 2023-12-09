use itertools::Itertools;

advent_of_code::solution!(9);

pub fn part_one(input: &str) -> Option<i32> {
    let sensor_readings = parse_input(input);

    Some(
        sensor_readings
            .iter()
            .map(|readings| extrapolate(readings))
            .sum(),
    )
}

pub fn part_two(input: &str) -> Option<u32> {
    None
}

fn extrapolate(readings: &[i32]) -> i32 {
    let mut differences: Vec<Vec<i32>> = vec![readings.to_vec()];

    let mut i = 0;
    loop {
        let difference = differences[i]
            .windows(2)
            .map(|window| window[1] - window[0])
            .collect_vec();

        let all_equal = difference.iter().all_equal();
        differences.push(difference);
        if all_equal {
            break;
        }
        i += 1;
    }

    // Add the last row of differences together to extrapolate the next number
    differences
        .iter()
        .map(|differences| differences.last().unwrap())
        .sum()
}

fn parse_input(input: &str) -> Vec<Vec<i32>> {
    input
        .lines()
        .map(|line| {
            line.split_whitespace()
                .map(|number| number.parse().unwrap())
                .collect_vec()
        })
        .collect_vec()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part_one() {
        let result = part_one(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(114));
    }

    #[test]
    fn test_part_two() {
        let result = part_two(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, None);
    }
}
