module Poker
  class Deck
    include Enumerable

    attr_reader :cards

    def initialize
      @cards = Poker::Card::RANKS.flat_map do |rank|
        Poker::Card::SUITS.flat_map do |suit|
          Poker::Card.new(rank, suit)
        end
      end.shuffle!
    end

    def each(&block)
      @cards.each(&block)
    end

  end
end
