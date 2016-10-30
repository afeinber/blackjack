class Hand < ApplicationRecord
  belongs_to :round
  has_many :cards, as: :cardable, autosave: true

  def low_value
    self.cards.map(&:low_value).reduce(0, :+)
  end

  def high_value
    self.cards.map(&:high_value).reduce(0, :+)
  end

  def best_value
    value = low_value
    ace_count = self.cards.where(rank: 'A').size
    while value <= 11 && ace_count > 0
      value += 10
      ace_count -= 1
    end
    value
  end
end
