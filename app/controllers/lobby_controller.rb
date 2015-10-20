class LobbyController < ApplicationController
  def show
    @contests = Contest.open
    @seasons = Season.all
    @rounds = Round.open
  end
end
