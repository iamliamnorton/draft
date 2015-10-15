class LobbyController < ApplicationController
  def show
    @contests = Contest.open
  end
end
