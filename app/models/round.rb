class Round < ApplicationRecord
  validates :bet, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
