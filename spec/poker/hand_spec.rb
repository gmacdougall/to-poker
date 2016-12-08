require 'spec_helper'

RSpec.describe Poker::Hand, type: :model do
  describe '#sets' do
    it 'places cards into their ranking slots' do
      cards = cyo_cards('three_of_a_kind')
      hand = Poker::Hand.new(cards)

      expect(hand.sets[2].length).to eq(3)
      expect(hand.sets[2].first.rank).to eq("3")
    end
  end

  def cyo_cards(type)
    cards = []
    case type
    when 'three_of_a_kind'
      3.times do |i|
        cards << Poker::Card.new('3', Poker::Card::SUITS[i])
      end
      cards << Poker::Card.new('5', 'Hearts')
      cards << Poker::Card.new('10', 'Spades')
    end

    cards
  end
end
