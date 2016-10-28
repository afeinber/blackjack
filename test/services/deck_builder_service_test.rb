require 'test_helper'

class DeckBuilderServiceTest < ActiveSupport::TestCase
  test "builds a deck with the correct number of cards" do
    deck = DeckBuilderService.build_deck

    assert_equal 52, deck.cards.size
  end

  test "creates a deck with cards using the shuffled suits and values" do
    DeckBuilderService::SUITS.stub :product, [["S1", "V1"]] do
      deck = DeckBuilderService.build_deck

      assert_equal 1, deck.cards.size
      assert_equal "S1", deck.cards.first.suit
      assert_equal "V1", deck.cards.first.value
      end
  end
end
