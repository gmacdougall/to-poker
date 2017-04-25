# frozen_string_literal: true

class Card
  attr_reader :suit, :value

  VALID_VALUES = (2..10).to_a + ['J', 'Q', 'K', 'A']
  VALID_SUITS = [:hearts, :clubs, :spades, :diamonds]

  InvalidSuitError = Class.new(StandardError)
  InvalidValueError = Class.new(StandardError)

  def initialize(value, suit)
    fail InvalidValueError unless VALID_VALUES.include?(value)
    fail InvalidSuitError unless VALID_SUITS.include?(suit)
    @value = value
    @suit = suit
  end

  def num_rank
    VALID_VALUES.find_index(value)
  end

  def inspect
    "#{@value}#{@suit.to_s.upcase[0]}"
  end
end
