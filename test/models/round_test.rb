require 'test_helper'

class RoundTest < ActiveSupport::TestCase
  let(:game) { Game.new(deck: Deck.new) }
  let(:round) { Round.new(game: game) }

  test "creates the correct hands" do
    game.deck.stub :pop, Card.new do
      round.deal_inital_hands

      assert_equal round.hands.size, 2
      assert_equal round.hands.first.is_dealer, true
      assert_equal round.hands.last.is_dealer, false
    end
  end

  test "assigns the correct cards" do
    game.deck.stub :pop, Card.new do
      round.deal_inital_hands

      assert_equal round.hands.first.cards.size, 2
      assert_equal round.hands.last.cards.size, 2
    end
  end
end
