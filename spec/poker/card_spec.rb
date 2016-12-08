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
end
