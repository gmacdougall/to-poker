module Poker
  class Deck

    attr_reader :cards

    def initialize
      @cards = []
      return create!
    end

    private

    def create!
      Poker::Card::RANKS.each do |rank|
        Poker::Card::SUITS.each do |suit|
          @cards << Poker::Card.new(rank, suit)
        end
      end
      @cards.shuffle!
    end
  end
end
