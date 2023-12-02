advent_of_code::solution!(1);

pub fn part_one(input: &str) -> Option<u32> {
    let mut result = 0;

    for line in input.lines() {
        let mut first_digit = None;
        let mut last_digit = None;
        for char in line.chars() {
            if char.is_numeric() {
                if first_digit.is_none() {
                    first_digit = Some(char);
                }
                last_digit = Some(char);
            }
        }
        let line_result = format!("{}{}", first_digit.unwrap(), last_digit.unwrap());
        let calibration_value: u32 = line_result.parse().unwrap();
        result += calibration_value;
    }

    Some(result)
}

pub fn part_two(input: &str) -> Option<u32> {
    None
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part_one() {
        let result = part_one(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(142));
    }

    #[test]
    fn test_part_two() {
        let result = part_two(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, None);
    }
}
