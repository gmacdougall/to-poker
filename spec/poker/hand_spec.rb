require 'spec_helper'

RSpec.describe Poker::Hand, type: :model do
  let(:hand) { Poker::Hand.new(cards) }
  let(:straight_flush) { FactoryGirl.build(:straight_flush) }
  let(:four_of_a_kind) { FactoryGirl.build(:four_of_a_kind) }
  let(:full_house) { FactoryGirl.build(:full_house) }
  let(:flush) { FactoryGirl.build(:flush) }
  let(:straight) { FactoryGirl.build(:straight) }
  let(:three_of_a_kind) { FactoryGirl.build(:three_of_a_kind) }
  let(:two_pair) { FactoryGirl.build(:two_pair) }
  let(:one_pair) { FactoryGirl.build(:one_pair) }

  describe '#straight_flush?' do
    subject { hand.straight_flush? }

    context 'all five cards are the same suit and they rank in a row' do
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

    context 'when the hand is not the same suit' do
      let(:cards) do
        [
          Poker::Card.new('2', 'Spades'),
          Poker::Card.new('3', 'Diamonds'),
          Poker::Card.new('4', 'Diamonds'),
          Poker::Card.new('5', 'Diamonds'),
          Poker::Card.new('6', 'Diamonds'),
        ]
      end

      it { is_expected.to be_falsey }
    end

    context 'when the hand does not rank in a row' do
      let(:cards) do
        [
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('3', 'Diamonds'),
          Poker::Card.new('Q', 'Diamonds'),
          Poker::Card.new('5', 'Diamonds'),
          Poker::Card.new('6', 'Diamonds'),
        ]
      end

      it { is_expected.to be_falsey }
    end
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
    subject { hand.full_house? }

    context 'when there are three cards of one rank' do
      context 'when the other two cards are the same rank' do
        let(:cards) do
          [
            Poker::Card.new('2', 'Diamonds'),
            Poker::Card.new('2', 'Hearts'),
            Poker::Card.new('2', 'Spades'),
            Poker::Card.new('5', 'Diamonds'),
            Poker::Card.new('5', 'Spades'),
          ]
        end

        it { is_expected.to be_truthy }
      end

      context 'when the other two cards are a different rank' do
        let(:cards) do
          [
            Poker::Card.new('2', 'Diamonds'),
            Poker::Card.new('2', 'Hearts'),
            Poker::Card.new('2', 'Spades'),
            Poker::Card.new('8', 'Diamonds'),
            Poker::Card.new('5', 'Spades'),
          ]
        end

        it { is_expected.to be_falsey }
      end
    end

    context 'when there are not three cards of one rank' do
      let(:cards) do
        [
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('2', 'Hearts'),
          Poker::Card.new('4', 'Spades'),
          Poker::Card.new('5', 'Diamonds'),
          Poker::Card.new('5', 'Spades'),
        ]
      end

      it { is_expected.to be_falsey }
    end
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

    context 'when cards do not rank in a row' do
      let(:cards) do
        [
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('2', 'Hearts'),
          Poker::Card.new('2', 'Spades'),
          Poker::Card.new('2', 'Clubs'),
          Poker::Card.new('3', 'Clubs'),
        ]
      end

      it { is_expected.to be_falsey }
    end

    context 'when Ace is involved and a straight' do
      let(:cards) do
        [
          Poker::Card.new('A', 'Clubs'),
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('3', 'Diamonds'),
          Poker::Card.new('4', 'Diamonds'),
          Poker::Card.new('5', 'Diamonds'),
        ]
      end

      it { is_expected.to be_truthy }
    end

    context 'when Ace is involved but not a straight' do
      let(:cards) do
        [
          Poker::Card.new('A', 'Clubs'),
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('3', 'Diamonds'),
          Poker::Card.new('4', 'Diamonds'),
          Poker::Card.new('K', 'Diamonds'),
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

  describe '#level' do
    context 'when the hand is a straight flush' do
      subject { straight_flush.level }

      context 'comparing if greater than a full_house' do
        it { is_expected.to be > full_house.level }
      end

      context 'comparing if greater than a straight' do
        it { is_expected.to be > straight.level }
      end

      context 'comparing if greater than a flush' do
        it { is_expected.to be > flush.level }
      end

      context 'comparing if greater than a four_of_a_kind' do
        it { is_expected.to be > four_of_a_kind.level }
      end

      context 'comparing if greater than a three_of_a_kind' do
        it { is_expected.to be > three_of_a_kind.level }
      end

      context 'comparing if greater than a two_pair' do
        it { is_expected.to be > two_pair.level }
      end

      context 'comparing if greater than a one_pair' do
        it { is_expected.to be > one_pair.level }
      end
    end
  end

  describe '<=>' do
    context 'when the hands are not the same level' do

      let(:cards) do
        [
          Poker::Card.new('2', 'Hearts'),
          Poker::Card.new('Q', 'Diamonds'),
          Poker::Card.new('2', 'Clubs'),
          Poker::Card.new('7', 'Diamonds'),
          Poker::Card.new('2', 'Spades'),
        ]
      end
      let(:cards2) do
        [
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('3', 'Diamonds'),
          Poker::Card.new('4', 'Diamonds'),
          Poker::Card.new('5', 'Diamonds'),
          Poker::Card.new('2', 'Clubs'),
        ]
      end
      let(:hand2) { Poker::Hand.new(cards2) }

      it 'returns false with ==' do
        expect(hand == hand2).to be_falsey
      end

      it 'returns false with <' do
        expect(hand < hand2).to be_falsey
      end

      it 'returns true with >' do
        expect(hand > hand2).to be_truthy
      end
    end

    context 'when both hand levels are the same but one has higher cards' do
      let(:cards) do
        [
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('3', 'Diamonds'),
          Poker::Card.new('4', 'Diamonds'),
          Poker::Card.new('5', 'Diamonds'),
          Poker::Card.new('2', 'Clubs'),
        ]
      end
      let(:cards2) do
        [
          Poker::Card.new('2', 'Hearts'),
          Poker::Card.new('Q', 'Diamonds'),
          Poker::Card.new('3', 'Clubs'),
          Poker::Card.new('7', 'Diamonds'),
          Poker::Card.new('2', 'Spades'),
        ]
      end
      let(:hand2) { Poker::Hand.new(cards2) }


      it 'returns false when asking if first hand is greater' do
        expect(hand > hand2).to be_falsey
      end

      it 'returns true when asking if second hand is greater' do
        expect(hand < hand2).to be_truthy
      end
    end
  end
end
