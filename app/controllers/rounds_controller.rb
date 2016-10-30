class RoundsController < ApplicationController
  def new
    @round = Round.new
    @round.game = Game.find(params[:game_id])
  end

  def create
    @round = Game.find(params[:game_id]).rounds.build
    @round.bet = round_params[:bet]
    @round.game.balance -= @round.bet
    @round.hands = @round.initial_hands

    if @round.game.save
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

    if @round.save
      redirect_to game_round_path(@round.game, @round)
    end
  end

  def double
    game = Game.includes(:rounds).find(params[:game_id])
    @round = game.rounds.find(params[:id])

    game.balance -= @round.bet
    @round.bet *= 2
    @round.doubled = true

    if ActiveRecord::Base.transaction { game.save && @round.save }
      redirect_to game_round_path(game, @round)
    else
      redirect_to :back, alert: "Something went wrong. Please try again."
    end
  end

  def stay
    game = Game.includes(:rounds).find(params[:game_id])
    @round = game.rounds.find(params[:id])

    @round.complete_round

    if @round.save
      redirect_to game_round_path(game, @round)
    end
  end

  private

  def round_params
    params.require(:round).permit(:bet)
  end
end
