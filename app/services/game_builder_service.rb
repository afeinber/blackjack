class GameBuilderService
  SUITS = %w(♠, ♣, ♥, ♦)
  VALUES = %w(2, 3, 4, 5, 6, 7, 8, 9, 10, J, Q, K, A)

  def self.build_game
    game = Game.new
    game.deck = build_deck
    game
  end

  def self.build_deck
    deck = Deck.new
    SUITS.each do |s|
      VALUES.each do |v|
        deck.cards.build(suit: s, value: v, cardable: deck)
      end
    end
    deck
  end
end
