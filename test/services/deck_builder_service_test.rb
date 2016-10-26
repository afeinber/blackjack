require 'test_helper'

class DeckBuilderServiceTest < ActiveSupport::TestCase
  test "builds a deck with the correct number of cards" do
    deck = DeckBuilderService.build_deck

    assert_equal deck.cards.size, 52
  end

  test "creates a deck with cards using the shuffled suits and values" do
    DeckBuilderService::SUITS.stub :shuffle, ["S1"] do
      DeckBuilderService::VALUES.stub :shuffle, ["V1"] do
        deck = DeckBuilderService.build_deck

        assert_equal deck.cards.size, 1
        assert_equal deck.cards.first.suit, "S1"
        assert_equal deck.cards.first.value, "V1"
      end
    end
  end
end
