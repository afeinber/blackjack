require 'test_helper'

class BugDemoTest < ActiveSupport::TestCase
  describe "polymorphic associations" do
    before do
      # make sure that the ID's start off at 1.
      DatabaseCleaner.clean
    end

    it "fails when the id is 1" do
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
      # ID is 1. Not working. Actual value here is 0.
      assert_equal 1, round.hands.first.reload.cards.size
    end

    it "succeeds otherwise" do
      ActiveRecord::Base.connection.execute("SELECT setval('hands_id_seq', 1000);")

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

      # ID is 1002. It works.
      assert_equal 1, round.hands.last.reload.cards.size
      # ID is 10001. It works.
      assert_equal 1, round.hands.first.reload.cards.size
    end
  end
end
