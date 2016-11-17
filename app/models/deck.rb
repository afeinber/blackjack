class Deck < ApplicationRecord
  belongs_to :game
  has_many :cards, as: :cardable

  def pop
    last_card = self.cards.last
    self.cards -= [last_card]
    last_card.reload
  end
end
