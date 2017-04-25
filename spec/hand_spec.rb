# frozen_string_literal: true

RSpec.describe Hand do
  let(:hand)  { described_class.new(cards) }

  describe 'validation' do
    subject { hand }

    context 'when I pass in 4 cards' do
      let(:cards) do
        [
          Card.new(2, :hearts),
          Card.new(3, :hearts),
          Card.new(4, :hearts),
          Card.new(7, :hearts),
        ]
      end

      it 'raises a InvalidNumberOfCardsError' do
        expect { subject }.to raise_error(Hand::InvalidNumberOfCardsError)
      end
    end

    context 'when I pass in 6 cards' do
      let(:cards) do
        [
          Card.new(2, :hearts),
          Card.new(3, :hearts),
          Card.new('J', :hearts),
          Card.new(7, :hearts),
          Card.new(8, :hearts),
          Card.new(10, :hearts),
        ]
      end

      it 'raises a InvalidNumberOfCardsError' do
        expect { subject }.to raise_error(Hand::InvalidNumberOfCardsError)
      end
    end

    context 'when I pass in 5 cards' do
      let(:cards) do
        [
          Card.new(2, :hearts),
          Card.new(3, :hearts),
          Card.new('J', :hearts),
          Card.new(7, :hearts),
          Card.new(8, :hearts),
        ]
      end

      it 'is a valid hand' do
        expect(subject.cards.size).to eq(Hand::VALID_SIZE)
      end
    end
  end

  describe '#rank' do
    subject { hand.rank }

    context 'when all cards are consecutive' do
      let(:cards) do
        [
          Card.new(2, :hearts),
          Card.new(3, :clubs),
          Card.new(4, :hearts),
          Card.new(5, :spades),
          Card.new(6, :hearts),
        ]
      end

      it { should eq :straight }
    end

    context 'when cards are 7 to jack in the wrong order' do
      let(:cards) do
        [
          Card.new(8, :hearts),
          Card.new(7, :clubs),
          Card.new(10, :hearts),
          Card.new(9, :spades),
          Card.new('J', :hearts),
        ]
      end

      it { should eq :straight }

    end

    context 'when cards are 10 to ace in the wrong order' do
      let(:cards) do
        [
          Card.new('K', :hearts),
          Card.new('Q', :clubs),
          Card.new(10, :hearts),
          Card.new('A', :spades),
          Card.new('J', :hearts),
        ]
      end

      it { should eq :straight }

    end

    context 'when cards are consecutive with Ace low' do
      let(:cards) do
        [
          Card.new(4, :hearts),
          Card.new(5, :clubs),
          Card.new(3, :hearts),
          Card.new('A', :spades),
          Card.new(2, :hearts),
        ]
      end

      it { should eq :straight }

    end

    context 'when all cards are the same suit' do
      let(:cards) do
        [
          Card.new(2, :hearts),
          Card.new(3, :hearts),
          Card.new(8, :hearts),
          Card.new('J', :hearts),
          Card.new('A', :hearts),
        ]
      end

      it { should eq :flush }
    end

    context 'when all cards are the same suit and consecutive' do
      let(:cards) do
        [
          Card.new(7, :hearts),
          Card.new(9, :hearts),
          Card.new(8, :hearts),
          Card.new(10, :hearts),
          Card.new('J', :hearts),
        ]
      end

      it { should eq :straight_flush }
    end

    context 'when four cards are the same' do
      let(:cards) do
        [
          Card.new(7, :hearts),
          Card.new(7, :clubs),
          Card.new(8, :hearts),
          Card.new(7, :spades),
          Card.new(7, :diamonds),
        ]
      end

      it { should be :four_of_a_kind }
    end

    context 'when three cards are the same' do
      context 'when the other two cards are different' do
        let(:cards) do
          [
            Card.new(7, :hearts),
            Card.new(9, :hearts),
            Card.new(8, :hearts),
            Card.new(7, :spades),
            Card.new(7, :diamonds),
          ]
        end

        it { should be :three_of_a_kind }
      end

      context 'when the other two cards are the same' do
        let(:cards) do
          [
            Card.new(7, :hearts),
            Card.new(9, :hearts),
            Card.new(9, :clubs),
            Card.new(7, :spades),
            Card.new(7, :diamonds),
          ]
        end

        it { should be :full_house }
      end
    end

    context 'when two cards are the same' do
      context 'when the other three cards are different' do
        let(:cards) do
          [
            Card.new(7, :hearts),
            Card.new(9, :hearts),
            Card.new(3, :hearts),
            Card.new(8, :spades),
            Card.new(7, :diamonds),
          ]
        end

        it { should be :one_pair }
      end

      context 'when the other three cards also contain a pair' do
        let(:cards) do
          [
            Card.new(7, :hearts),
            Card.new(9, :hearts),
            Card.new(9, :clubs),
            Card.new(7, :spades),
            Card.new(2, :diamonds),
          ]
        end

        it { should be :two_pair }
      end
    end

    context 'when all cards are different ranks and not consecutive' do
      let(:cards) do
        [
          Card.new(2, :hearts),
          Card.new(3, :clubs),
          Card.new(8, :hearts),
          Card.new('J', :spades),
          Card.new('A', :hearts),
        ]
      end

      it { should eq :high_card }
    end
  end

  describe 'comparison' do
    let(:straight_flush) do
      Hand.new [
        Card.new(7, :hearts),
        Card.new(9, :hearts),
        Card.new(8, :hearts),
        Card.new(10, :hearts),
        Card.new('J', :hearts),
      ]
    end

    let(:four_of_a_kind) do
      Hand.new [
        Card.new(7, :hearts),
        Card.new(7, :clubs),
        Card.new(8, :hearts),
        Card.new(7, :spades),
        Card.new(7, :diamonds),
      ]
    end

    let(:full_house) do
      Hand.new [
        Card.new(7, :hearts),
        Card.new(7, :clubs),
        Card.new(8, :hearts),
        Card.new(8, :spades),
        Card.new(7, :diamonds),
      ]
    end

    let(:two_pair) do
      Hand.new [
        Card.new(3, :hearts),
        Card.new(7, :clubs),
        Card.new(8, :hearts),
        Card.new(8, :spades),
        Card.new(7, :diamonds),
      ]
    end

    it 'lets straight_flush beat four of a kind' do
      straight_flush > four_of_a_kind
    end

    it 'lets four of a kind beat full house' do
      full_house < four_of_a_kind
    end

    it 'allows use of max' do
      expect([straight_flush, four_of_a_kind, full_house].max).to be straight_flush
    end

    it 'allows use of sort' do
      expect([
        two_pair,
        four_of_a_kind,
        straight_flush,
        full_house
      ].sort).to eq([
        two_pair,
        full_house,
        four_of_a_kind,
        straight_flush,
      ])
    end
  end
end
