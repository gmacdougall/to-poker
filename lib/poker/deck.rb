module Poker
  class Deck

    attr_reader :cards

    def initialize
      @cards = Poker::Card::RANKS.flat_map do |rank|
        Poker::Card::SUITS.flat_map do |suit|
          Poker::Card.new(rank, suit)
        end
      end.shuffle!
    end

  end
end
