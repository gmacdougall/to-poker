module Poker
  class Hand

    def initialize(cards)
      @cards = cards
      @sets = sets
    end

    def straight_flush?
      straight? && flush?
    end

    def four_of_a_kind?
      of_a_kind?(4)
    end

    def full_house?
      three_of_a_kind? && one_pair?
    end

    def flush?
      @cards.map { |c| c.suit }.uniq.length == 1
    end

    def straight?
      standard_straight? || ace_low_straight?
    end

    def three_of_a_kind?
      of_a_kind?(3)
    end

    def two_pair?
      one_pair? && @sets.select { |k,v| v == 2 }.length == 2
    end

    def one_pair?
      of_a_kind?(2)
    end

    def of_a_kind?(number)
      @sets.values.any? {|s| s == number }
    end

    def level
      if straight_flush?
        8
      elsif four_of_a_kind?
        7
      elsif full_house?
        6
      elsif flush?
        5
      elsif straight?
        4
      elsif three_of_a_kind?
        3
      elsif two_pair?
        2
      elsif one_pair?
        1
      else
        0
      end
    end

    private

    def standard_straight?
      @sets.keys.length == 5 && @sets.keys == (@sets.keys.first..@sets.keys.last).to_a
    end

    def ace_low_straight?
      sets.keys == [1, 2, 3, 4, 13]
    end

    def sets
      sets = @cards.inject(Hash.new(0)) do |hash, card|
        hash[card.number_value] += 1
        hash
      end

      Hash[sets.sort]
    end
  end
end
