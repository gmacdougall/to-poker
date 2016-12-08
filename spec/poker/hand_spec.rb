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
    let(:cards) { cyo_cards(3) }
    let(:hand) { Poker::Hand.new(cards) }

    it 'returns true when there are three of the same rank' do
      expect(hand.three_of_a_kind?).to be_truthy
    end

    it 'returns false when there are not three of the same rank' do
      cards = cyo_cards(2)
      hand = Poker::Hand.new(cards)

      expect(hand.three_of_a_kind?).to be_falsey
    end

    it 'receives of_a_kind?' do
      expect(hand).to receive(:of_a_kind?)

      hand.three_of_a_kind?
    end
  end

  describe '#two_pair?' do
    let(:cards) { cyo_cards('two_pair') }
    let(:hand) { Poker::Hand.new(cards) }

    it 'returns true when there are two different pairs in the hand' do

      expect(hand.two_pair?).to be_truthy
    end

    it 'returns true when there is only one pair in the hand' do
      cards = cyo_cards(2)
      hand = Poker::Hand.new(cards)

      expect(hand.two_pair?).to be_falsey
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


  def cyo_cards(type)
    cards = []

    if type.is_a? Integer
      type.times do |i|
        cards << Poker::Card.new('3', Poker::Card::SUITS[i])
      end
      cards_left = (5 - type)

      cards_left.times do |i|
        cards << Poker::Card.new((4..10).to_a.map(&:to_s).sample, Poker::Card::SUITS[i])
      end
    else
      case type
      when 'two_pair'
        ranks = ['2', '2', '3', '3']
        4.times do |i|
          cards << Poker::Card.new(ranks[i], Poker::Card::SUITS[i])
        end
        cards << Poker::Card.new('10', 'Spades')
      when 'straight'
        5.times do |i|
          cards << Poker::Card.new(Poker::Card::RANKS[i], Poker::Card::SUITS.sample)
        end
      end
    end

    return cards
  end
end
