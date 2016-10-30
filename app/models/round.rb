class Round < ApplicationRecord
  belongs_to :game
  has_many :hands, autosave: true

  validates :bet, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :result, inclusion: { in: %w(win loss tie) }, allow_nil: true
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

  def hit
    player_hand.cards << game.deck.pop

    if player_hand.over_twenty_one?
      self.completed = true
      self.result = :loss
    end
  end

  def can_double?
    !doubled && game.balance >= bet
  end

  def player_hand
    @player_hand ||= hands.where(is_dealer: false).first
  end

  def dealer_hand
    @dealer_hand ||= hands.where(is_dealer: true).first
  end

  def complete_round
    self.completed = true

    while dealer_hand.high_value < 17
      dealer_hand.cards << game.deck.pop
    end

    if player_hand.best_value > dealer_hand.best_value || dealer_hand.over_twenty_one?
      self.result = :win
    end
  end
end
