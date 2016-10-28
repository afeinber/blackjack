class RoundsController < ApplicationController
  def new
    @round = Round.new
    @round.game = Game.find(params[:game_id])
  end

  def create
    @round = Round.new(round_params)
    @round.game = Game.find(params[:game_id])
    @round.hands = @round.initial_hands

    if @round.save
      redirect_to game_round_path(@round.game, @round)
    end
  end

  def show
    @round = Round.joins(:game).find(params[:id])
  end

  def hit
    @round = Round.joins(:game).find(params[:id])
    @round.player_hand.cards << @round.game.deck.pop

    if @round.save
      redirect_to game_round_path(@round.game, @round)
    end
  end

  private

  def round_params
    params.require(:round).permit(:bet)
  end
end
