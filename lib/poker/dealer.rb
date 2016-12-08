module Poker
  class Dealer
    attr_reader :deck, :hands

    def initialize(num_players)
      @num_players = num_players
      @deck = Poker::Deck.new
      @hands = []
    end

    def deal_round
      @num_players.times do
        @hands << deal
      end
    end

    def winner
      hand_rankings = {}

      @hands.each {|h| hand_rankings[h.level] = [] }
      @hands.each do |h|
        hand_rankings[h.level] << h
      end

      max_key = hand_rankings.keys.max
      hand_rankings.select! { |k,v| k == max_key }

      hand_rankings[max_key]
    end


    private

    def deal
      Poker::Hand.new(@deck.cards.pop(5))
    end
  end
end
