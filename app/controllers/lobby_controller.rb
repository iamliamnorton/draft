class LobbyController < ApplicationController
  def show
    @contests = Contest.open
    @sports = Sport.all
  end
end
