class Round < ApplicationRecord
  belongs_to :game
  has_many :hands, autosave: true

  validates :bet, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :game, presence: true

  def initial_hands
    new_hands = [Hand.new(is_dealer: true), Hand.new(is_dealer: false)]

    2.times do
      new_hands.each do |hand|
        hand.cards << game.deck.pop
      end
    end

    new_hands
  end

  def player_hand
    @player_hand ||= hands.where(is_dealer: false).first
  end

  def dealer_hand
    @dealer_hand ||= hands.where(is_dealer: true).first
  end
end
