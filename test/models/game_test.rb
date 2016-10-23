require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "shows the correct inital balance" do
    game = Game.new

    assert_equal game.balance, Game::INITIAL_BALANCE
  end

  test "shows the balance minus the bets" do
    game = Game.new
    game.rounds << Round.new(bet: 50)

    assert_equal game.balance, Game::INITIAL_BALANCE - 50
  end
end
