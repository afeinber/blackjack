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
end
