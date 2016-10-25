class Game < ApplicationRecord
  INITIAL_BALANCE = 1000

  has_many :rounds, dependent: :destroy
  has_one :deck, autosave: true

  def balance
    INITIAL_BALANCE - rounds.map(&:bet).reduce(0, :+)
  end
end
