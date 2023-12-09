use itertools::Itertools;

advent_of_code::solution!(7);

#[derive(Debug, Eq, PartialEq, PartialOrd, Ord)]
enum HandType {
    HighCard,
    OnePair,
    TwoPair,
    ThreeOfAKind,
    FullHouse,
    FourOfAKind,
    FiveOfAKind,
}

#[derive(Debug)]
struct CamelPokerHand {
    cards: [u8; 5],
    bid: u32,
}

impl CamelPokerHand {
    fn get_type(&self, jokers: bool) -> HandType {
        let mut counter: [u32; 14] = [0; 14];

        for card in self.cards {
            counter[card as usize] += 1;
        }
        let [joker_count, mut counter @ ..] = counter;

        if jokers {
            *counter.iter_mut().max().unwrap() += joker_count;
        }

        let sorted_groups: Vec<(usize, u32)> = counter
            .into_iter()
            .enumerate()
            .filter(|(_, card)| card > &0)
            .sorted_by(|a, b| b.1.cmp(&a.1))
            .collect_vec();

        match sorted_groups.len() {
            1 => HandType::FiveOfAKind,
            2 => {
                if sorted_groups.first().unwrap().1 == 4 {
                    HandType::FourOfAKind
                } else {
                    HandType::FullHouse
                }
            }
            3 => {
                if sorted_groups.first().unwrap().1 == 3 {
                    HandType::ThreeOfAKind
                } else {
                    HandType::TwoPair
                }
            }
            4 => HandType::OnePair,
            5 => HandType::HighCard,
            _ => panic!("Cannot happen"),
        }
    }
}

pub fn part_one(input: &str) -> Option<u32> {
    Some(calculate_winnings(input, false))
}

pub fn part_two(input: &str) -> Option<u32> {
    Some(calculate_winnings(input, true))
}

fn calculate_winnings(input: &str, jokers: bool) -> u32 {
    let mut winnings = input
        .lines()
        .map(|line| parse_hand(line, jokers))
        .map(|hand| {
            let hand_type = hand.get_type(jokers);
            (hand_type, hand.cards, hand.bid)
        })
        .collect_vec();

    winnings.sort_unstable();

    winnings
        .iter()
        .zip(1..)
        .map(|((_, _, bid), rank)| rank * bid)
        .sum()
}

fn parse_hand(line: &str, jokers: bool) -> CamelPokerHand {
    let (cards, bid) = line.split_once(' ').unwrap();
    CamelPokerHand {
        cards: std::array::from_fn(|i| parse_card(&cards.as_bytes()[i], jokers)),
        bid: bid.parse().unwrap(),
    }
}

fn parse_card(char: &u8, jokers: bool) -> u8 {
    (match char {
        b'A' => 14,
        b'K' => 13,
        b'Q' => 12,
        b'J' => {
            if jokers {
                1
            } else {
                11
            }
        }
        b'T' => 10,
        digit => digit - b'0',
    }) - 1
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part_one() {
        let result = part_one(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(6440));
    }

    #[test]
    fn test_part_two() {
        let result = part_two(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(5905));
    }
}
