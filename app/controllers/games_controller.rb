class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.new

    if @game.save
      redirect_to new_game_round_path(@game)
    end
  end
end
