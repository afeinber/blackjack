require 'test_helper'

class BlackJackTest < ActionDispatch::IntegrationTest
  test "can see their money" do
    get "/"

    assert_select "h3", "Your balance: 1000 roubles"
  end
end
