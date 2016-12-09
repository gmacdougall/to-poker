require 'spec_helper'


RSpec.describe Poker::Dealer, type: :model do
  let(:dealer) { Poker::Dealer.new(3) }
  let(:straight_flush) { FactoryGirl.build(:straight_flush) }
  let(:straight) { FactoryGirl.build(:straight) }
  let(:straight_with_ace) { FactoryGirl.build(:straight_with_ace) }
  let(:three_of_a_kind) { FactoryGirl.build(:three_of_a_kind) }
  let(:one_pair) { FactoryGirl.build(:one_pair) }

  describe '#deal_round' do
    subject { dealer.deal_round }

    it 'creates 3 hands' do
      expect{ subject }.to change { dealer.hands.length }.from(0).to(3)
    end
  end

  describe '#winner' do
    before do
      dealer.deal_round
    end

    it 'returns the hand of the winner' do
      dealer.instance_variable_set("@hands", [
        straight_flush,
        one_pair,
        three_of_a_kind,
      ])

      expect(dealer.winner).to eq([straight_flush])
    end

    it 'returns a tie of winners' do
      dealer.instance_variable_set("@hands", [
        straight_flush,
        straight_flush,
        three_of_a_kind,
      ])

      expect(dealer.winner).to eq([straight_flush, straight_flush])
    end

    context 'all hands have no matches' do
      let(:hand) do
        Poker::Hand.new(
          [
            Poker::Card.new('3', 'Hearts'),
            Poker::Card.new('2', 'Diamonds'),
            Poker::Card.new('8', 'Spades'),
            Poker::Card.new('5', 'Clubs'),
            Poker::Card.new('Q', 'Diamonds'),
          ]
        )
      end
      let(:hand2) do
        Poker::Hand.new(
          [
            Poker::Card.new('3', 'Hearts'),
            Poker::Card.new('2', 'Diamonds'),
            Poker::Card.new('8', 'Spades'),
            Poker::Card.new('5', 'Clubs'),
            Poker::Card.new('K', 'Diamonds'),
          ]
        )
      end

      it 'picks the hand with the highest card' do
        dealer.instance_variable_set("@hands", [
          hand,
          hand,
          hand2
        ])

        expect(dealer.winner).to eq([hand2])
      end
    end

    context 'with ace low straight and normal straight' do

      it 'picks the straight to win' do
        dealer.instance_variable_set("@hands", [
          straight,
          straight_with_ace,
          one_pair,
        ])

        expect(dealer.winner).to eq([straight])
      end
    end
  end
end
