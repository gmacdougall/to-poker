require 'spec_helper'

RSpec.describe Poker::Hand, type: :model do
  let(:hand) { Poker::Hand.new(cards) }

  describe '#straight_flush?' do
  end

  describe '#four_of_a_kind?' do
    subject { hand.four_of_a_kind? }
    let(:cards) {
      [
        Poker::Card.new('2', 'Diamonds'),
        Poker::Card.new('2', 'Spades'),
        Poker::Card.new('2', 'Hearts'),
        Poker::Card.new('5', 'Diamonds'),
        Poker::Card.new('2', 'Clubs'),
      ]
    }

    context 'when there are four of the same rank' do
      it { is_expected.to be_truthy }
    end

    context 'when there are not four of the same rank' do
      let(:cards) do
        [
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('3', 'Diamonds'),
          Poker::Card.new('4', 'Diamonds'),
          Poker::Card.new('5', 'Diamonds'),
          Poker::Card.new('6', 'Clubs'),
        ]
      end

      it { is_expected.to be_falsey }
    end
  end

  describe '#full_house?' do
  end

  describe '#flush?' do

    subject { hand.flush? }

    context 'when all the cards are the same suit' do
      let(:cards) do
        [
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('3', 'Diamonds'),
          Poker::Card.new('4', 'Diamonds'),
          Poker::Card.new('5', 'Diamonds'),
          Poker::Card.new('6', 'Diamonds'),
        ]
      end

      it { is_expected.to be_truthy }
    end

    context 'when all the cards are not the same suit' do
      let(:cards) do
        [
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('3', 'Diamonds'),
          Poker::Card.new('4', 'Diamonds'),
          Poker::Card.new('5', 'Diamonds'),
          Poker::Card.new('6', 'Clubs'),
        ]
      end

      it { is_expected.to be_falsey }
    end
  end

  describe '#straight?' do
    subject { hand.straight? }

    context 'when cards rank in a row' do
      let(:cards) do
        [
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('3', 'Diamonds'),
          Poker::Card.new('4', 'Diamonds'),
          Poker::Card.new('5', 'Diamonds'),
          Poker::Card.new('6', 'Clubs'),
        ]
      end

      it { is_expected.to be_truthy }
    end

    context 'when cards do not rank in a row' do
      let(:cards) do
        [
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('3', 'Diamonds'),
          Poker::Card.new('4', 'Diamonds'),
          Poker::Card.new('9', 'Diamonds'),
          Poker::Card.new('6', 'Clubs'),
        ]
      end

      it { is_expected.to be_falsey }
    end
  end

  describe '#three_of_a_kind?' do
    subject { hand.three_of_a_kind? }

    context 'when there are three of the same rank' do
      let(:cards) {
        [
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('2', 'Spades'),
          Poker::Card.new('4', 'Hearts'),
          Poker::Card.new('5', 'Diamonds'),
          Poker::Card.new('2', 'Clubs'),
        ]
      }

      it { is_expected.to be_truthy }
    end

    context 'when there are not three of the same rank' do
      let(:cards) {
        [
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('8', 'Spades'),
          Poker::Card.new('4', 'Hearts'),
          Poker::Card.new('5', 'Diamonds'),
          Poker::Card.new('2', 'Clubs'),
        ]
      }

      it { is_expected.to be_falsey }
    end
  end

  describe '#two_pair?' do
    subject { hand.two_pair? }

    context 'when there are two different pairs in the hand' do
      let(:cards) do
        [
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('3', 'Diamonds'),
          Poker::Card.new('4', 'Diamonds'),
          Poker::Card.new('3', 'Hearts'),
          Poker::Card.new('2', 'Clubs'),
        ]
      end

      it { is_expected.to be_truthy }
    end

    context 'when there is only one pair in the hand' do
      let(:cards) do
        [
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('3', 'Diamonds'),
          Poker::Card.new('4', 'Diamonds'),
          Poker::Card.new('5', 'Diamonds'),
          Poker::Card.new('2', 'Clubs'),
        ]
      end

      it { is_expected.to be_falsey }
    end
  end

  describe '#one_pair?' do
    subject { hand.one_pair? }

    context 'when there are two of the same rank' do
      let(:cards) do
        [
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('3', 'Diamonds'),
          Poker::Card.new('4', 'Diamonds'),
          Poker::Card.new('5', 'Diamonds'),
          Poker::Card.new('2', 'Clubs'),
        ]
      end

      it { is_expected.to be_truthy }
    end

    context 'when there are not two of the same rank' do
      let(:cards) do
        [
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('3', 'Diamonds'),
          Poker::Card.new('4', 'Diamonds'),
          Poker::Card.new('5', 'Diamonds'),
          Poker::Card.new('6', 'Clubs'),
        ]
      end

      it { is_expected.to be_falsey }
    end
  end
end
