class GameBuilderService
  def self.build_game
    game = Game.new
    game.deck = DeckBuilderService.build_deck
    game
  end
end
