require 'test_helper'

class BlackJackTest < ActionDispatch::IntegrationTest
  test "can see their money" do
    visit "/"

    assert page.has_content? "Your balance: 1000 roubles"
  end

  test "can play a round" do
    visit "/"

    fill_in 'round_bet', with: 50
    click_on 'Create Round'

    # assert page.has_content? "Your balance: 950 roubles"
    assert page.has_content? "Your bet: 50 roubles"
  end
end
