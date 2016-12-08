module Poker
  class Deck

    attr_accessor :contents

    def initialize
      @contents = []
      return create!
    end

    def shuffle
      @contents.shuffle!
    end

    private

    def create!
      Poker::Card::RANKS.each do |rank|
        Poker::Card::SUITS.each do |suit|
          @contents << Poker::Card.new(rank, suit)
        end
      end
      @contents
    end
  end
end
