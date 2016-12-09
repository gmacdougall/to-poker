require 'spec_helper'


RSpec.describe Poker::Deck, type: :model do
  describe '#initialize' do
    it 'has class variable of cards' do
      deck = Poker::Deck.new

      expect(deck.cards).to_not be_nil
      expect(deck.cards).to be_kind_of(Array)
    end

    it 'cards has length of 52' do
      deck = Poker::Deck.new

      expect(deck.cards.length).to eq(52)
    end
  end
end
