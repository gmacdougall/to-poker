require 'rspec'
require 'spec_helper'

RSpec.describe Poker::Card, type: :model do
  it 'has class variable of suit' do
    card = Poker::Card.new('Queen', 'Hearts')

    expect(card.suit).to eq('Hearts')
  end

  it 'has class variable of rank' do
    card = Poker::Card.new('Queen', 'Hearts')

    expect(card.rank).to eq('Queen')
  end

  describe 'SUITS' do
    it 'should include Hearts, Diamonds, Clubs, and Spades' do
      suits = ["Hearts", "Diamonds", "Clubs", "Spades"]

      expect(Poker::Card::SUITS).to include(*suits)
    end
  end

  describe 'RANKS' do
    it 'should include numbers 2 through 10' do
      expect(Poker::Card::RANKS).to include(*(2..10).to_a.map(&:to_s))
    end

    it 'should include J, Q, K, A' do
      face_cards = ['J', 'Q', 'K', 'A']

      expect(Poker::Card::RANKS).to include(*face_cards)
    end
  end
end
