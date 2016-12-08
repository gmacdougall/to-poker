module Poker
  class Hand

    def initialize(cards)
      @cards = cards
      @sets = sets
    end

    def straight_flush?
      # same suit, ranks in a row
    end

    def four_of_a_kind?
      of_a_kind?(4)
    end

    def full_house?
      # 3 cards of one rank, 2 cards of another rank
    end

    def flush?
      # 5 cards of all the same suit
    end

    def straight?
      @sets.keys == (@sets.keys.first..@sets.keys.last).to_a
    end

    def three_of_a_kind?
      of_a_kind?(3)
    end

    def two_pair?
      one_pair? && @sets.select {|k,v| v.length == 2}.length == 2
    end

    def one_pair?
      of_a_kind?(2)
    end

    def high_card?
      # research more later
    end

    def of_a_kind?(number)
      @sets.values.any? { |s| s.length == number }
    end

    private

    def sets
      sets = {}
      @cards.each {|c| sets[c.number_value] = [] }
      @cards.each do |c|
        sets[c.number_value] << c
      end
      sets.sort_by {|k,v| k}.to_h
    end
  end
end


# straight flush
# four of a kind
# full house
# flush
# straight
# three of a kind
# two pair
# one pair
# high card
