module Poker
  class Dealer
    class EmptyDeckError < StandardError; end

    attr_reader :deck, :hands

    def initialize(num_players)
      @num_players = num_players
      @deck = Poker::Deck.new
      @hands = []
    end

    def deal_round
      @hands = Array.new(@num_players) { deal }
    end

    def winner
      max_key = @hands.map { |h| h.level }.max

      @hands.select { |h| h.level == max_key }
    end


    private

    def deal
      Poker::Hand.new(@deck.cards.pop(5))

      raise EmptyDeckError if @deck.cards.empty?
    end
  end
end
