require 'test_helper'

class BlackJackTest < ActionDispatch::IntegrationTest
  test "can see their money" do
    visit "/"

    assert page.has_content? "Your balance: 1000 roubles"
  end

  test "can bet money" do
    visit "/"

    fill_in 'round_bet', with: 50
  end
end
