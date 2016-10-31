class RoundsController < ApplicationController
  MIN_CARDS_FOR_NEW_ROUND = 4

  def new
    game = Game.find(params[:game_id])

    if game.deck.cards.count < MIN_CARDS_FOR_NEW_ROUND
      game.completed = true
      game.save
    end

    @round = game.rounds.build
  end

  def create
    @round = Game.find(params[:game_id]).rounds.build
    @round.bet = round_params[:bet]
    @round.game.balance -= @round.bet
    @round.hands = @round.initial_hands

    if ActiveRecord::Base.transaction { @round.save && @round.game.save }
      redirect_to game_round_path(@round.game, @round)
    else
      redirect_to :back, alert: "Something went wrong. Please try again."
    end
  end

  def show
    @round = Round.includes(hands: [:cards]).find(params[:id])
  end

  def hit
    @round = Round.includes(:game).find(params[:id])
    @round.hit

    if ActiveRecord::Base.transaction { @round.game.save && @round.save }
      redirect_to game_round_path(@round.game, @round)
    else
      redirect_to :back, alert: "Something went wrong. Please try again."
    end
  end

  def double
    @round = Round.includes(:game).find(params[:id])
    @round.game.balance -= @round.bet
    @round.bet *= 2
    @round.doubled = true

    if ActiveRecord::Base.transaction { @round.game.save && @round.save }
      redirect_to game_round_path(@round.game, @round)
    else
      redirect_to :back, alert: "Something went wrong. Please try again."
    end
  end

  def stay
    @round = Round.includes(:game).find(params[:id])

    @round.complete_round

    if ActiveRecord::Base.transaction { @round.game.save && @round.save }
      redirect_to game_round_path(@round.game, @round)
    else
      redirect_to :back, alert: "Something went wrong. Please try again."
    end
  end

  private

  def round_params
    params.require(:round).permit(:bet)
  end
end
