require 'test_helper'

class RoundTest < ActiveSupport::TestCase
  test "deals the inital hands" do
    game = GameBuilderService.build_game
    round = Round.new(game: game)
    round.deal_inital_hands

    assert_equal round.hands.size, 2
    assert_equal round.hands.first.cards.size, 2
  end
end
