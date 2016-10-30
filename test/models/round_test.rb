require 'test_helper'

class RoundTest < ActiveSupport::TestCase
  let(:game) { create(:game) }
  let(:round) { create(:round, game: game) }

  describe "#initial_hands" do
    it "creates the correct hands" do
      game.deck.stub :pop, Card.new do
        new_hands = round.initial_hands

        assert_equal new_hands.size, 2
        assert_equal new_hands.first.is_dealer, true
        assert_equal new_hands.last.is_dealer, false
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
      round.game.deck.cards << Card.new
      round.save
    end

    it "adds a new card to the players hand" do
      round.hit

      assert_equal 1, round.player_hand.cards.size
    end

    it "marks the round completed and lost if the player is over 21" do
      round.player_hand.stub :over_twenty_one?, true do
        round.hit

        assert_equal true, round.completed
        assert_equal 'loss', round.result
      end
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
      round.game.deck.cards << create(:card, rank: 'Q', cardable: round.game.deck)

      round.complete_round

      assert_equal 'win', round.result
    end

    it "marks the game as a win if the player has a higher hand value" do
      round.player_hand.cards << build(:card, rank: 'A')
      round.player_hand.cards << build(:card, rank: 'K')

      round.complete_round

      assert_equal 'win', round.result
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
