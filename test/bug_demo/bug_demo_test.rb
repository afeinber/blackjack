require 'test_helper'

class BugDemoTest < ActiveSupport::TestCase
  describe "the bug" do
    before do
      DatabaseCleaner.clean
    end

    it "happens when the id is 1" do
      game = GameBuilderService.build_game
      game.save!

      round = game.rounds.build
      round.hands = [
        build(:hand, cards: [
          game.deck.pop
        ]),
        build(:hand, cards: [
          game.deck.pop
        ]),
      ]

      round.save!

      # ID is 2. It works.
      assert_equal 1, round.hands.last.reload.cards.size
      # ID is 1. Not working.
      assert_equal 1, round.hands.first.reload.cards.size
    end
  end
end
