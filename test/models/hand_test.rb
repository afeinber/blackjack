require 'test_helper'

class HandTest < ActiveSupport::TestCase
  let(:hand) { create(:hand) }

  describe '#best_value' do
    it 'returns the value if there are no aces' do
      hand.cards = [
        build(:card, rank: '5'),
        build(:card, rank: '7')
      ]

      assert_equal 12, hand.best_value
    end

    it 'returns the high value of an ace if possible' do
      hand.cards = [
        build(:card, rank: 'A'),
        build(:card, rank: 'K'),
      ]

      assert_equal 21, hand.best_value
    end

    it 'returns the low value of an ace if necessary' do
      hand.cards = [
        build(:card, rank: 'A'),
        build(:card, rank: 'K'),
        build(:card, rank: '2'),
      ]

      assert_equal 13, hand.best_value
    end

    it 'returns 0 if over 21' do
      hand.cards = [
        build(:card, rank: 'Q'),
        build(:card, rank: 'K'),
        build(:card, rank: '2'),
      ]

      assert_equal 0, hand.best_value
    end
  end

  describe "#over_twenty_one?" do
    it 'returns false if under or equal to twenty-one' do
      hand.cards = [
        build(:card, rank: "5"),
        build(:card, rank: "7"),
        build(:card, rank: "9"),
      ]

      assert_equal false, hand.over_twenty_one?
    end

    it 'returns true if over twenty-one' do
      hand.cards = [
        build(:card, rank: "K"),
        build(:card, rank: "K"),
        build(:card, rank: "2"),
      ]

      assert_equal true, hand.over_twenty_one?
    end
  end
end
