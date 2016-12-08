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
    end

    def full_house?
      # 3 cards of one rank, 2 cards of another rank
    end

    def flush?
      # 5 cards of all the same suit
    end

    def straight?
      # any suit, ranks in a row
    end

    def three_of_a_kind?
    end

    def two_pair?
      # two of one rank, two of another rank, and one of a different rank
    end

    def one_pair?
      # two of one rank, rest of other ranks
    end

    def high_card?
      # research more later
    end


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
