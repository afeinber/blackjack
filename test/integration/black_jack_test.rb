require 'test_helper'

class BlackJackTest < ActionDispatch::IntegrationTest
  test "can see their money" do
    visit "/"
    click_on 'Start Game'

    assert page.has_content? "Your balance: 1000 roubles"
  end

  test "can start a game" do
    visit "/"
    click_on 'Start Game'

    fill_in 'round_bet', with: 50
    click_on 'Create Round'

    assert page.has_content? "Your balance: 950 roubles"
    assert page.has_content? "Your bet: 50 roubles"
    assert page.has_selector? ".player-hand .card", count: 2
    within(:css, ".dealer-hand .card:nth-of-type(2)") do
      assert page.has_content? "????"
    end
  end
end
