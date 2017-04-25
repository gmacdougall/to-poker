# frozen_string_literal: true

RSpec.describe Card do
  let(:card) { Card.new(value, suit) }
  let(:value) { 3 }
  let(:suit) { :hearts }

  describe '#suit' do
    subject { card.suit }

    it 'returns the suit of the card' do
      expect(subject).to eq(:hearts)
    end

    context 'when the suit is spades' do
      let(:suit) { :spades }

      it 'returns spades' do
        expect(subject).to eq(:spades)
      end
    end

    context 'when the suit is rubies' do
      let(:suit) { :rubies }

      it 'raises an InvalidSuitError' do
        expect { subject }.to raise_error(Card::InvalidSuitError)
      end
    end
  end

  describe '#value' do
    subject { card.value }

    it { is_expected.to eq 3 }

    context 'when the value is invalid' do
      let(:value) { 15 }

      it 'raises an error' do
        expect { subject }.to raise_error(Card::InvalidValueError)
      end
    end

    context 'when the value is a king' do
      let(:value) { 'K' }
      it { is_expected.to eq "K" }
    end
  end

  describe '#num_rank' do
    subject { card.num_rank }

    context 'when the value is 4' do
      let(:value) { 4 }
      it { should be 2 }
    end

    context 'when the value is Q' do
      let(:value) { 'Q' }
      it { should be 10 }
    end
  end
end
