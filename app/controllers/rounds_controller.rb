class RoundsController < ApplicationController
  def new
    @round = Round.new
  end
end
