FactoryGirl.define do
  factory :hand, class: Poker::Hand do
    initialize_with do
      ranks = Poker::Card::RANKS.shuffle
      suits = Poker::Card::SUITS
      new((0..4).map {|c| Poker::Card.new(ranks.pop, suits.sample) })
    end
  end

  factory :straight_flush, class: Poker::Hand do
    initialize_with do
      new(
        [
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('3', 'Diamonds'),
          Poker::Card.new('4', 'Diamonds'),
          Poker::Card.new('5', 'Diamonds'),
          Poker::Card.new('6', 'Diamonds'),
        ]
      )
    end
  end

  factory :four_of_a_kind, class: Poker::Hand do
    initialize_with do
      new(
        [
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('2', 'Spades'),
          Poker::Card.new('2', 'Hearts'),
          Poker::Card.new('5', 'Clubs'),
          Poker::Card.new('2', 'Clubs'),
        ]
      )
    end
  end

  factory :full_house, class: Poker::Hand do
    initialize_with do
      new(
        [
          Poker::Card.new('7', 'Diamonds'),
          Poker::Card.new('7', 'Hearts'),
          Poker::Card.new('7', 'Spades'),
          Poker::Card.new('8', 'Diamonds'),
          Poker::Card.new('8', 'Spades'),
        ]
      )
    end
  end

  factory :flush, class: Poker::Hand do
    initialize_with do
      new(
        [
          Poker::Card.new('2', 'Hearts'),
          Poker::Card.new('3', 'Hearts'),
          Poker::Card.new('8', 'Hearts'),
          Poker::Card.new('5', 'Hearts'),
          Poker::Card.new('6', 'Hearts'),
        ]
      )
    end
  end

  factory :straight, class: Poker::Hand do
    initialize_with do
      new(
        [
          Poker::Card.new('2', 'Spades'),
          Poker::Card.new('3', 'Spades'),
          Poker::Card.new('4', 'Spades'),
          Poker::Card.new('5', 'Spades'),
          Poker::Card.new('6', 'Clubs'),
        ]
      )
    end
  end

  factory :straight_with_ace, class: Poker::Hand do
    initialize_with do
      new(
        [
          Poker::Card.new('A', 'Clubs'),
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('3', 'Diamonds'),
          Poker::Card.new('4', 'Diamonds'),
          Poker::Card.new('5', 'Diamonds'),
        ]
      )
    end
  end

  factory :three_of_a_kind, class: Poker::Hand do
    transient do
      match_rank nil
      high_card nil
    end

    initialize_with do
      new(
        [
          Poker::Card.new(match_rank || '4', 'Diamonds'),
          Poker::Card.new(match_rank || '4', 'Spades'),
          Poker::Card.new(match_rank || '4', 'Hearts'),
          Poker::Card.new(high_card || '5', 'Clubs'),
          Poker::Card.new('2', 'Clubs'),
        ]
      )
    end
  end

  factory :two_pair, class: Poker::Hand do
    transient do
      one_pair_rank nil
      high_card nil
    end

    initialize_with do
      new(
        [
          Poker::Card.new(one_pair_rank || '7', 'Diamonds'),
          Poker::Card.new('J', 'Spades'),
          Poker::Card.new('J', 'Hearts'),
          Poker::Card.new(high_card || '5', 'Clubs'),
          Poker::Card.new(one_pair_rank || '7', 'Clubs'),
        ]
      )
    end
  end

  factory :one_pair, class: Poker::Hand do
    initialize_with do
      new(
        [
          Poker::Card.new('K', 'Diamonds'),
          Poker::Card.new('Q', 'Spades'),
          Poker::Card.new('J', 'Hearts'),
          Poker::Card.new('4', 'Clubs'),
          Poker::Card.new('Q', 'Clubs'),
        ]
      )
    end
  end
end
