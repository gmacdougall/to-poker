# frozen_string_literal: true

class Hand
  include Comparable

  InvalidNumberOfCardsError = Class.new(StandardError)

  VALID_SIZE = 5

  RANKED_HANDS = [
    :straight_flush,
    :four_of_a_kind,
    :full_house,
    :flush,
    :straight,
    :three_of_a_kind,
    :two_pair,
    :one_pair,
    :high_card,
  ].reverse

  attr_reader :cards

  def initialize(cards)
    fail InvalidNumberOfCardsError unless cards.length == VALID_SIZE
    @cards = cards
  end

  def num_rank
    RANKED_HANDS.find_index(rank)
  end

  def rank
    if all_consecutive? && all_same_suit?
      :straight_flush
    elsif all_consecutive?
      :straight
    elsif all_same_suit?
      :flush
    elsif frequencies.values.any? { |val| val == 4 }
      :four_of_a_kind
    elsif frequencies.values.any? { |val| val == 3 }
      if frequencies.values.any? { |val| val == 2 }
        :full_house
      else
        :three_of_a_kind
      end
    elsif frequencies.values.any? { |val| val == 2 }
      if frequencies.count == 3
        :two_pair
      else
        :one_pair
      end
    else
      :high_card
    end
  end

  def <=>(other)
    num_rank <=> other.num_rank
  end

  def inspect
    self.cards.map { |card| card.inspect }.join(',')
  end

  private

  def all_consecutive?
    (9.times.map { |n| (n..(n+4)).to_a } + [[0, 1, 2, 3, 12]]).any? do |str|
      str == self.cards.map(&:num_rank).sort
    end
  end

  def all_same_suit?
    self.cards.map(&:suit).uniq.count == 1
  end

  def frequencies
    freq = Hash.new(0)
    self.cards.each do |card|
      freq[card.num_rank] += 1
    end
    freq
  end
end
