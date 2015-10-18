class LobbyController < ApplicationController
  def show
    @contests = Contest.open
    @sports = Sport.all
    @rounds = Round.open
  end
end
