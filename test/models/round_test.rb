require 'test_helper'

class RoundTest < ActiveSupport::TestCase
  let(:game) { create(:game, balance: 1000) }
  let(:round) { create(:round, game: game) }

  describe "#initial_hands" do
    it "creates the correct hands" do
      game.deck.stub :pop, Card.new do
        new_hands = round.initial_hands

        assert_equal new_hands.size, 2
        assert_equal new_hands.first.is_dealer, false
        assert_equal new_hands.last.is_dealer, true
      end
    end

    it "assigns the correct cards" do
      game.deck.stub :pop, Card.new do
        new_hands = round.initial_hands

        assert_equal new_hands.first.cards.size, 2
        assert_equal new_hands.last.cards.size, 2
      end
    end
  end

  describe "#hit" do
    before do
      round.hands.build(is_dealer: false)
      round.hands.build(is_dealer: true)
      round.game.deck.cards << build(:card, rank: 2)
      round.save
    end

    it "adds a new card to the players hand" do
      round.hit

      assert_equal 1, round.player_hand.cards.size
    end

    it "marks the round completed and lost if the player is over 21" do
      round.dealer_hand.cards = [
        build(:card, rank: '2'),
        build(:card, rank: '2'),
      ]
      round.player_hand.cards = [
        build(:card, rank: 'K'),
        build(:card, rank: 'K'),
      ]

      round.hit

      assert_equal true, round.completed
      assert_equal 'loss', round.result
    end
  end

  describe "#complete_round" do
    before do
      round.hands.build(is_dealer: true)
      round.hands.build(is_dealer: false)
      round.save

      # give value 16 to the dealer
      round.dealer_hand.cards.create(suit: "S1", rank: "K")
      round.dealer_hand.cards.create(suit: "S2", rank: "6")
    end

    it "marks the round as complete" do
      round.complete_round

      assert_equal true, round.completed
    end

    it "deals cards to the dealer if dealers hand < 17" do
      round.complete_round

      assert_equal round.dealer_hand.cards.size, 3
    end

    it "marks the game as a win if the dealer goes over 21" do
      round.player_hand.cards << build(:card, rank: '2')
      round.player_hand.cards << build(:card, rank: '2')

      round.game.deck.cards << build(:card, rank: 'Q')

      round.complete_round

      assert_equal 'win', round.result
    end

    it "marks the game as a win if the player has a higher hand value" do
      round.player_hand.cards << build(:card, rank: 'A')
      round.player_hand.cards << build(:card, rank: 'K')

      round.complete_round

      assert_equal 'win', round.result
    end

    it "rewards the player if the player wins" do
      round.bet = 100
      round.player_hand.cards << build(:card, rank: 'A')
      round.player_hand.cards << build(:card, rank: 'K')

      round.complete_round

      assert_equal round.game.balance, 1200
    end

    it "marks the game as a tie if the player and dealer have the same hand value" do
      round.player_hand.cards << build(:card, rank: 'A')
      round.player_hand.cards << build(:card, rank: 'K')
      round.game.deck.cards << build(:card, rank: '5')

      round.complete_round

      assert_equal 'tie', round.result
    end

    it "returns the bet to the player if it's a tie" do
      round.player_hand.cards << build(:card, rank: 'A')
      round.player_hand.cards << build(:card, rank: 'K')
      round.game.deck.cards << build(:card, rank: '5')

      round.complete_round

      assert_equal round.game.balance, 1000
    end

    it "marks the game as a loss if the player has a lower hand value" do
      round.player_hand.cards << build(:card, rank: '2')
      round.player_hand.cards << build(:card, rank: '3')
      round.game.deck.cards << build(:card, rank: '5')

      round.complete_round

      assert_equal 'loss', round.result
    end

    it "ends the game if the balance is 0" do
      round.game.balance = 0

      round.complete_round

      assert_equal true, round.game.completed
    end
  end

  describe "#can_double?" do
    before do
      game.balance = 100
      game.save
    end

    it "returns false if doubling would give negative balance" do
      round.bet = 101

      assert_equal false, round.can_double?
    end

    it "returns false if already doubled" do
      round.doubled = true

      assert_equal false, round.can_double?
    end

    it "returns true otherwise" do
      assert_equal true, round.can_double?
    end
  end
end
