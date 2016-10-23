class RoundsController < ApplicationController
  def new
    @round = Round.new
  end

  def create
    @round = Round.new(round_params)

    if @round.save
      redirect_to @round
    end
  end

  def show
    @round = Round.find(params[:id])
  end

  private

  def round_params
    params.require(:round).permit(:bet)
  end
end
