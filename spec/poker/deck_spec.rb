require 'spec_helper'


RSpec.describe Poker::Deck, type: :model do
  describe '#initialize' do
    it 'has class variable of contents' do
      deck = Poker::Deck.new

      expect(deck.contents).to_not be_nil
      expect(deck.contents).to be_kind_of(Array)
    end
    it 'receives create on initialize' do
      expect_any_instance_of(Poker::Deck).to receive(:create!)

      Poker::Deck.new
    end

    it 'contents has length of 52' do
      deck = Poker::Deck.new

      expect(deck.contents.length).to eq(52)
    end
  end
end
