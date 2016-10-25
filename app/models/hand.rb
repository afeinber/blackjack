class Hand < ApplicationRecord
  belongs_to :round
  has_many :cards, as: :cardable
end
