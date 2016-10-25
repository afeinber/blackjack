require 'test_helper'

class GameBuilderServiceTest < ActiveSupport::TestCase
  test "builds a proper deck" do
    deck = GameBuilderService.build_deck

    assert_equal deck.cards.size, 52
  end
end

