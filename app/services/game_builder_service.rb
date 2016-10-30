class GameBuilderService
  INITIAL_BALANCE = 1000

  def self.build_game
    game = Game.new(balance: INITIAL_BALANCE)
    game.deck = DeckBuilderService.build_deck
    game
  end
end
