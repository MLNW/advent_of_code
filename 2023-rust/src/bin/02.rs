advent_of_code::solution!(2);

#[derive(Debug)]
struct Game {
    id: u32,
    sets: Vec<Set>,
}

#[derive(Debug)]
struct Set {
    cubes: Vec<ColorCount>,
}

#[derive(Debug)]
enum Color {
    Red,
    Green,
    Blue,
}

#[derive(Debug)]
struct ColorCount {
    color: Color,
    count: u32,
}

pub fn part_one(input: &str) -> Option<u32> {
    parse_games(input)
        .into_iter()
        .filter(is_possible)
        .map(|game| game.id)
        .reduce(|acc, id| acc + id)
}

pub fn part_two(input: &str) -> Option<u32> {
    parse_games(input)
        .into_iter()
        .map(minimum_set)
        .map(game_power)
        .reduce(|acc, power| acc + power)
}

fn is_possible(game: &Game) -> bool {
    for set in &game.sets {
        let valid = set
            .cubes
            .iter()
            .map(|ColorCount { color, count }| match color {
                Color::Red => count <= &12,
                Color::Green => count <= &13,
                Color::Blue => count <= &14,
            })
            .all(|valid| valid);
        if !valid {
            return false;
        }
    }
    true
}

fn minimum_set(game: Game) -> Set {
    let mut red = ColorCount {
        color: Color::Red,
        count: 0,
    };
    let mut green = ColorCount {
        color: Color::Green,
        count: 0,
    };
    let mut blue = ColorCount {
        color: Color::Blue,
        count: 0,
    };

    for set in game.sets {
        for ColorCount { color, count } in set.cubes {
            let color = match color {
                Color::Red => &mut red,
                Color::Green => &mut green,
                Color::Blue => &mut blue,
            };
            if count > color.count {
                color.count = count;
            }
        }
    }

    Set {
        cubes: Vec::from([red, green, blue]),
    }
}

fn game_power(minimum_set: Set) -> u32 {
    minimum_set
        .cubes
        .iter()
        .map(|ColorCount { count, .. }| *count)
        .reduce(|acc, count| acc * count)
        .unwrap()
}

fn parse_games(input: &str) -> Vec<Game> {
    input
        .lines()
        .map(|line| line.trim_start_matches("Game "))
        .map(|line| line.split_once(": "))
        .map(|split| {
            let (id, sets) = split.unwrap();
            Game {
                id: id.parse().unwrap(),
                sets: sets.split(';').map(parse_set).collect(),
            }
        })
        .collect::<Vec<Game>>()
}

fn parse_set(input: &str) -> Set {
    let cubes: Vec<ColorCount> = input
        .split(',')
        .map(|color| {
            let (count, name) = color.trim().split_once(' ').unwrap();
            let count = count.parse().unwrap();
            let color = match name {
                "red" => Color::Red,
                "blue" => Color::Blue,
                "green" => Color::Green,
                _ => panic!("Only these colors exist"),
            };
            ColorCount { color, count }
        })
        .collect();

    Set { cubes }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part_one() {
        let result = part_one(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(8));
    }

    #[test]
    fn test_part_two() {
        let result = part_two(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(2286));
    }
}
