use regex::{Captures, Regex};

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
    let regex = Regex::new(r"(one|two|three|four|five|six|seven|eight|nine)").unwrap();
    let replacement = |caps: &Captures| -> String {
        match &caps[0] {
            "one" => String::from("1e"),
            "two" => String::from("t2o"),
            "three" => String::from("th3e"),
            "four" => String::from("f4"),
            "five" => String::from("f5e"),
            "six" => String::from("6"),
            "seven" => String::from("s7n"),
            "eight" => String::from("e8t"),
            "nine" => String::from("n9e"),
            _ => caps[0].to_string()
        }
    };

    let mut replaced_input = String::new();
    for line in input.lines() {
        let replaced_line = &regex.replace_all(line, &replacement);
        replaced_input += &regex.replace_all(replaced_line, &replacement);
        replaced_input += "\n";
    }

    part_one(&replaced_input)
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
        let result = part_two(&advent_of_code::template::read_file_part(
            "examples", DAY, 2,
        ));
        assert_eq!(result, Some(303));
    }
}
