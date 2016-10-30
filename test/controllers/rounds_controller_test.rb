require 'test_helper'

class RoundsControllerTest < ActionDispatch::IntegrationTest
  describe "#hit" do
    let(:game) { Game.create(deck: Deck.new) }
    let(:round) { Round.create(game: game) }

    before do
      game.deck.cards.create(suit: "S1", rank: "R1")
      round.hands.create(is_dealer: false)
    end

    it "redirects to the game round page if successful" do
      patch "/games/#{game.id}/rounds/#{round.id}/hit"

      assert_redirected_to game_round_path(game, round)
    end
  end
end

