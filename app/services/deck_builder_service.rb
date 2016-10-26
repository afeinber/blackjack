class DeckBuilderService
  SUITS = %w(♠, ♣, ♥, ♦)
  VALUES = %w(2, 3, 4, 5, 6, 7, 8, 9, 10, J, Q, K, A)

  def self.build_deck
    deck = Deck.new
    SUITS.shuffle.each do |s|
      VALUES.shuffle.each do |v|
        deck.cards.build(suit: s, value: v, cardable: deck)
      end
    end
    deck
  end
end
