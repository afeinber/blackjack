class Round < ApplicationRecord
  belongs_to :game

  validates :bet, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :game, presence: true
end
