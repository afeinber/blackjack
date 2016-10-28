require 'test_helper'

class BlackJackTest < ActionDispatch::IntegrationTest
  def start_game
    visit "/"
    click_on 'Start Game'
  end

  test "can see their money" do
    start_game

    assert page.has_content? "Your balance: 1000 roubles"
  end

  test "can start a game" do
    start_game
    fill_in 'round_bet', with: 50
    click_on 'Create Round'

    assert page.has_content? "Your balance: 950 roubles"
    assert page.has_content? "Your bet: 50 roubles"
    assert page.has_selector? ".player-hand .card", count: 2
    within(:css, ".dealer-hand .card:nth-of-type(2)") do
      assert page.has_content? "????"
    end
  end

  test "can hit on a round" do
    start_game
    fill_in 'round_bet', with: 50
    click_on 'Create Round'
    click_on 'Hit'
    assert page.has_selector? ".player-hand .card", count: 3
  end

  test "can double their bet" do
    start_game
    fill_in 'round_bet', with: 50
    click_on 'Create Round'
    click_on 'Double'

    assert page.has_content? "Your bet: 100 roubles"
  end
end
