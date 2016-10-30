require 'test_helper'

class HandTest < ActiveSupport::TestCase
  let(:hand) { create(:hand) }

  describe '#best_value' do
    it 'returns the value if there are no aces' do
      hand.cards = [Card.new(rank: '5'), Card.new(rank: '7')]

      assert_equal 12, hand.best_value
    end

    it 'returns the high value of an ace if possible' do
      hand.cards = [
        build(:card, rank: 'A'),
        build(:card, rank: 'K'),
      ]

      assert_equal 21, hand.best_value
    end

    it 'returns the lowvalue of an ace if necessary' do
      hand.cards = [
        build(:card, rank: 'A'),
        build(:card, rank: 'K'),
        build(:card, rank: '2'),
      ]

      assert_equal 13, hand.best_value
    end
  end

  describe "#over_twenty_one?" do
    it 'returns false if under or equal to twenty-one' do
      hand.cards = [
        create(:card, rank: "5", cardable: hand),
        create(:card, rank: "7", cardable: hand),
        create(:card, rank: "9", cardable: hand),
      ]

      assert_equal false, hand.over_twenty_one?
    end

    it 'returns true if over twenty-one' do
      hand.cards = [
        create(:card, rank: "K", cardable: hand),
        create(:card, rank: "K", cardable: hand),
        create(:card, rank: "2", cardable: hand),
      ]

      assert_equal true, hand.over_twenty_one?
    end
  end
end
