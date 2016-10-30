class DeckBuilderService
  SUITS = %w(♠ ♣ ♥ ♦)
  RANKS = %w(2 3 4 5 6 7 8 9 10 J Q K A)

  def self.build_deck
    deck = Deck.new
    SUITS.product(RANKS).shuffle.each do |combo|
      deck.cards.build(suit: combo[0], rank: combo[1], cardable: deck)
    end
    deck
  end
end
