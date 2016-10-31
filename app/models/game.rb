class Game < ApplicationRecord
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  has_many :rounds, dependent: :destroy
  has_one :deck
end
