class Card < ApplicationRecord
  belongs_to :cardable, polymorphic: true
end
