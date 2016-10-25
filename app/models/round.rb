class Round < ApplicationRecord
  belongs_to :game
  has_many :hands, autosave: true

  validates :bet, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :game, presence: true

  def deal_inital_hands
    player_hand = self.hands.build
    dealer_hand = self.hands.build

    player_hand.cards << game.deck.pop
    player_hand.cards << game.deck.pop
    dealer_hand.cards << game.deck.pop
    dealer_hand.cards << game.deck.pop
  end
end
