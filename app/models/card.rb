class Card < ApplicationRecord
  belongs_to :cardable, polymorphic: true

  def low_value
    rank == 'A' ? 1 : non_ace_value
  end

  private

  def non_ace_value
    rank.to_i == 0 ? 10 : rank.to_i
  end
end
