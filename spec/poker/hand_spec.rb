require 'spec_helper'

RSpec.describe Poker::Hand, type: :model do
  let(:hand) { Poker::Hand.new(cards) }
  let(:straight_flush) { FactoryGirl.build(:straight_flush) }
  let(:four_of_a_kind) { FactoryGirl.build(:four_of_a_kind) }
  let(:full_house) { FactoryGirl.build(:full_house) }
  let(:flush) { FactoryGirl.build(:flush) }
  let(:straight) { FactoryGirl.build(:straight) }
  let(:straight_with_ace) { FactoryGirl.build(:straight_with_ace) }
  let(:three_of_a_kind) { FactoryGirl.build(:three_of_a_kind) }
  let(:two_pair) { FactoryGirl.build(:two_pair) }
  let(:one_pair) { FactoryGirl.build(:one_pair) }

  describe '#straight_flush?' do
    subject { hand.straight_flush? }

    context 'all five cards are the same suit and they rank in a row' do
      let(:hand) { straight_flush }

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

    context 'when there are four of the same rank' do
      let(:hand) { four_of_a_kind }

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
        let(:hand) { full_house }

        it { is_expected.to be_truthy }
      end

      context 'when the other two cards are a different rank' do
        let(:hand) { three_of_a_kind }

        it { is_expected.to be_falsey }
      end
    end

    context 'when there are not three cards of one rank' do
      let(:hand) { one_pair }

      it { is_expected.to be_falsey }
    end
  end

  describe '#flush?' do

    subject { hand.flush? }

    context 'when all the cards are the same suit' do
      let(:hand) { flush }

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
      let(:hand) { straight }

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
      let(:hand) { straight_with_ace }

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
      let(:hand) { three_of_a_kind }

      it { is_expected.to be_truthy }
    end

    context 'when there are not three of the same rank' do
      let(:hand) { straight } # straights cant have same rank

      it { is_expected.to be_falsey }
    end
  end

  describe '#two_pair?' do
    subject { hand.two_pair? }

    context 'when there are two different pairs in the hand' do
      let(:hand) { two_pair }

      it { is_expected.to be_truthy }
    end

    context 'when there is only one pair in the hand' do
      let(:hand) { one_pair }

      it { is_expected.to be_falsey }
    end
  end

  describe '#one_pair?' do
    subject { hand.one_pair? }

    context 'when there are two of the same rank' do
      let(:hand) { one_pair }

      it { is_expected.to be_truthy }
    end

    context 'when there are not two of the same rank' do
      let(:hand) { straight } # straights cant have same rank

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

      it 'returns true with >' do
        hand1 = FactoryGirl.build(:straight_flush)
        hand2 = FactoryGirl.build(:straight)

        expect(hand1).to be > hand2
      end

      it 'returns false with ==' do
        hand1 = FactoryGirl.build(:straight_flush)
        hand2 = FactoryGirl.build(:straight)

        expect(hand1).to_not be == hand2
      end

      it 'returns false with ==' do
        hand1 = FactoryGirl.build(:straight_flush)
        hand2 = FactoryGirl.build(:straight)

        expect(hand1).to_not be < hand2
      end
    end

    context 'when both hand levels are the same' do
      context 'hand2 has higher match cards' do

        it 'returns true' do
          hand1 = FactoryGirl.build(:two_pair)
          hand2 = FactoryGirl.build(:two_pair, one_pair_rank: 'Q')

          expect(hand1).to be < hand2
        end
      end

      context 'hand2 has a higher high card' do
        it 'returns true' do
          hand1 = FactoryGirl.build(:two_pair)
          hand2 = FactoryGirl.build(:two_pair, high_card: 'Q')

          expect(hand1).to be < hand2
        end
      end
    end

    context 'when both hands ranks are exactly the same' do
      # Crazy scenario
      it 'returns true' do
        hand1 = FactoryGirl.build(:flush)
        hand2 = FactoryGirl.build(:flush)

        expect(hand1).to be == hand2
      end
    end

    context 'when there are no matches' do
      context 'when all the cards are the same except one' do
        let(:cards) do
          [
            Poker::Card.new('2', 'Diamonds'),
            Poker::Card.new('2', 'Hearts'),
            Poker::Card.new('8', 'Hearts'),
            Poker::Card.new('5', 'Spades'),
            Poker::Card.new('K', 'Hearts'),
          ]
        end
        let(:cards2) do
          [
            Poker::Card.new('2', 'Hearts'),
            Poker::Card.new('2', 'Diamonds'),
            Poker::Card.new('8', 'Spades'),
            Poker::Card.new('5', 'Clubs'),
            Poker::Card.new('Q', 'Diamonds'),
          ]
        end

        let(:hand2) { Poker::Hand.new(cards2) }

        it 'returns true for hand1 being greater than hand2' do
          expect(hand).to be > hand2
        end
      end
    end

    context 'when hands are same level but one hand has a higher match' do
      let(:cards) do
        [
          Poker::Card.new('2', 'Diamonds'),
          Poker::Card.new('2', 'Hearts'),
          Poker::Card.new('8', 'Hearts'),
          Poker::Card.new('5', 'Spades'),
          Poker::Card.new('K', 'Hearts'),
        ]
      end
      let(:cards2) do
        [
          Poker::Card.new('3', 'Hearts'),
          Poker::Card.new('3', 'Diamonds'),
          Poker::Card.new('8', 'Spades'),
          Poker::Card.new('5', 'Clubs'),
          Poker::Card.new('Q', 'Diamonds'),
        ]
      end
      let(:hand2) { Poker::Hand.new(cards2) }

      it 'returns true for hand2 being greater than hand1' do
        expect(hand).to be < hand2
      end
    end
  end

  describe '#sorted_sets' do
    context 'with no matches' do
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

      it 'match decesending array' do
        sorted_set_array = [11, 7, 4, 2, 1]

        expect(hand.sorted_sets).to match_array(sorted_set_array)
      end

      it 'array equals sets highest key' do
        highest_sorted_key = hand.sorted_sets[0]
        sets = highest_sets_key = hand.send(:sets).keys.last

        expect(highest_sorted_key).to eq(highest_sets_key)
      end
    end

    context 'with two pair' do
      let(:hand) { FactoryGirl.build(:two_pair) }

      it 'sorts to put the highest rank with the most matches first' do
        highest_rank = hand.sorted_sets[0]

        expect(hand.send(:sets)[highest_rank]).to eq(2)
      end

      it 'sorts to put the second rank with the most matches second' do
        second_highest = hand.sorted_sets[1]

        expect(hand.send(:sets)[second_highest]).to eq(2)
      end
    end

    context 'with ace low straight' do
      let(:hand) { FactoryGirl.build(:straight_with_ace) }

      it 'matches the adjust ace low straight array' do
        adj_ace_low_straight_array = [0, 1, 2, 3, 4]

        expect(hand.sorted_sets).to match_array(adj_ace_low_straight_array)
      end
    end
  end
end
