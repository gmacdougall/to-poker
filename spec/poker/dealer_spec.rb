require 'spec_helper'


RSpec.describe Poker::Dealer, type: :model do
  let(:dealer) { Poker::Dealer.new(3) }

  describe '#deal_round' do
    subject { dealer.deal_round }

    it 'creates 3 hands' do
      expect{ subject }.to change { dealer.hands.length }.from(0).to(3)
    end
  end

  describe '#winner' do
    let(:straight_flush) {
      Poker::Hand.new([
        Poker::Card.new('2', 'Diamonds'),
        Poker::Card.new('3', 'Diamonds'),
        Poker::Card.new('4', 'Diamonds'),
        Poker::Card.new('5', 'Diamonds'),
        Poker::Card.new('6', 'Diamonds'),
      ])
    }
    before do
      dealer.deal_round
    end
    it 'returns the hand of the winner' do
      dealer.instance_variable_set("@hands", [
        straight_flush,
        Poker::Hand.new([
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('8', 'Spades'),
          Poker::Card.new('4', 'Hearts'),
          Poker::Card.new('5', 'Diamonds'),
          Poker::Card.new('2', 'Clubs'),
        ]),
        Poker::Hand.new([
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('2', 'Hearts'),
          Poker::Card.new('2', 'Spades'),
          Poker::Card.new('8', 'Diamonds'),
          Poker::Card.new('5', 'Spades'),
        ]),
      ])

      expect(dealer.winner).to eq([straight_flush])
    end
    it 'returns a tie of winners' do
      dealer.instance_variable_set("@hands", [
        straight_flush,
        straight_flush,
        Poker::Hand.new([
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('2', 'Hearts'),
          Poker::Card.new('2', 'Spades'),
          Poker::Card.new('8', 'Diamonds'),
          Poker::Card.new('5', 'Spades'),
        ]),
      ])

      expect(dealer.winner).to eq([straight_flush, straight_flush])
    end
  end
end
