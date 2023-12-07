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
    fn get_type(&self) -> HandType {
        let sorted_groups: Vec<(u8, u32)> = self
            .cards
            .iter()
            .into_group_map_by(|card| *card)
            .values()
            .map(|cards| (*cards[0], cards.len() as u32))
            .sorted_by(|a, b| b.1.cmp(&a.1))
            .collect();

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
    let mut winnings = input
        .lines()
        .map(parse_hand)
        .map(|hand| {
            let hand_type = hand.get_type();
            (hand_type, hand.cards, hand.bid)
        })
        .collect_vec();

    winnings.sort_unstable();

    Some(
        winnings
            .iter()
            .zip(1..)
            .map(|((_, _, bid), rank)| rank * bid)
            .sum(),
    )
}

pub fn part_two(input: &str) -> Option<u32> {
    None
}

fn parse_hand(line: &str) -> CamelPokerHand {
    let (cards, bid) = line.split_once(' ').unwrap();
    CamelPokerHand {
        cards: std::array::from_fn(|i| parse_card(&cards.as_bytes()[i])),
        bid: bid.parse().unwrap(),
    }
}

fn parse_card(char: &u8) -> u8 {
    match char {
        b'A' => 14,
        b'K' => 13,
        b'Q' => 12,
        b'J' => 11,
        b'T' => 10,
        digit => digit - b'0',
    }
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
        assert_eq!(result, None);
    }
}
