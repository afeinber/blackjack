class Round < ApplicationRecord
  belongs_to :game
  has_many :hands

  DEALER_MIN = 17

  validates :bet, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :result, inclusion: { in: %w(win loss tie) }, allow_nil: true
  validates :game, presence: true

  def initial_hands
    [
      self.hands.build(is_dealer: false, cards: [
        game.deck.pop, game.deck.pop
      ]),
      self.hands.build(is_dealer: true, cards: [
        game.deck.pop, game.deck.pop
      ]),
    ]
  end

  def hit
    player_hand.cards << game.deck.pop

    if player_hand.over_twenty_one?
      self.complete_round
    end
  end

  def can_double?
    !doubled && game.balance >= bet
  end

  def can_hit?
    self.game.deck.cards.size > 0
  end

  def player_hand
    @player_hand ||= self.hands.find_by(is_dealer: false)
  end

  def dealer_hand
    @dealer_hand ||= self.hands.find_by(is_dealer: true)
  end

  def complete_round
    self.completed = true

    deal_dealer_cards unless player_hand.over_twenty_one?

    if player_hand.best_value > dealer_hand.best_value
      self.result = 'win'
      self.game.balance += self.bet * 2
    elsif player_hand.best_value == dealer_hand.best_value
      self.result = 'tie'
      self.game.balance += self.bet
    else
      self.result = 'loss'
    end

    self.game.completed = self.game.balance == 0
  end

  private

  def deal_dealer_cards
    while dealer_hand.high_value < DEALER_MIN && self.game.deck.cards.count > 0
      dealer_hand.cards << game.deck.pop
    end
  end
end
