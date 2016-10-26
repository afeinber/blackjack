require 'test_helper'

class GameBuilderServiceTest < ActiveSupport::TestCase
  test "assigns a deck using the deck builder service" do
    deck = Deck.new

    DeckBuilderService.stub :build_deck, deck do
      assert_equal GameBuilderService.build_game.deck, deck
    end
  end
end

