require 'test_helper'

class CardTest < ActiveSupport::TestCase
  describe "#low_value" do
    it "calculates the correct low_value for non-face cards" do
      card = Card.new(rank: '2')

      assert_equal card.low_value, 2
    end

    it "calculates the correct low_value for face cards" do
      card = Card.new(rank: 'Q')

      assert_equal card.low_value, 10
    end

    it "calculates the correct low_value for aces" do
      card = Card.new(rank: 'A')

      assert_equal card.low_value, 1
    end
  end

  describe "#high_value" do
    it "calculates the correct high_value for aces" do
      card = Card.new(rank: 'A')

      assert_equal card.high_value, 11
    end
  end
end
