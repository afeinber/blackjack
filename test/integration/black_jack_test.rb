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
    assert page.has_content? "Your balance: 900 roubles"
  end

  test "can see results if over 21" do
    start_game
    game = Game.last
    game.deck.cards = [
      Card.new(suit: "s1", rank: 'Q'),
      Card.new(suit: "s1", rank: 'K'),
      Card.new(suit: "s1", rank: 'J'),
      Card.new(suit: "s2", rank: 'Q'),
      Card.new(suit: "s1", rank: 'K'),
    ]
    game.save
    fill_in 'round_bet', with: 50
    click_on 'Create Round'
    click_on 'Hit'
    click_on "play another round!"

    assert page.has_content? "Your balance: 950 roubles"
  end

  test "can choose to stay, and sees the dealers hand" do
    start_game
    fill_in 'round_bet', with: 50
    click_on 'Create Round'
    click_on 'Stay'
    within(:css, ".dealer-hand .card:nth-of-type(2)") do
      assert page.has_no_content? "????"
    end
  end

  test "player stays and wins" do
    start_game
    fill_in 'round_bet', with: 50
    click_on 'Create Round'
    round = Round.last
    round.player_hand.cards = [
      Card.new(suit: "s1", rank: "A"),
      Card.new(suit: "s2", rank: "K"),
    ]
    round.dealer_hand.cards = [
      Card.new(suit: "s1", rank: "A"),
      Card.new(suit: "s2", rank: "6"),
    ]
    round.save
    click_on 'Stay'

    assert page.has_content? "You won!"
    assert page.has_content? "Your balance: 1050 roubles"
  end

  test "dealer goes over 21" do
    start_game
    fill_in 'round_bet', with: 50
    click_on 'Create Round'
    round = Round.last
    round.player_hand.cards = [
      Card.new(suit: "s1", rank: "2"),
      Card.new(suit: "s2", rank: "2"),
    ]
    round.dealer_hand.cards = [
      Card.new(suit: "s1", rank: "K"),
      Card.new(suit: "s2", rank: "6"),
    ]
    round.game.deck.cards.push(Card.new(suit: 'S3', rank: 'Q'))
    round.save
    click_on 'Stay'

    assert page.has_content? "You won!"
  end

  test "balance runs out" do
    start_game
    game = Game.last
    game.deck.cards = [
      Card.new(suit: "s1", rank: 'Q'),
      Card.new(suit: "s1", rank: 'K'),
      Card.new(suit: "s1", rank: 'J'),
      Card.new(suit: "s2", rank: 'Q'),
      Card.new(suit: "s1", rank: 'K'),
    ]
    game.save!
    fill_in 'round_bet', with: 1000
    click_on 'Create Round'
    click_on 'Hit'

    assert page.has_content? "Game over!"
  end

  test "deck has no cards left" do
    game = GameBuilderService.build_game
    game.deck.cards = create_list(:card, 3, cardable: game.deck)
    game.save!

    visit "/games/#{game.id}/rounds/new"

    assert page.has_content? "Game over! There are no cards left."
  end
end
