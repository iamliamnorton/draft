class LobbyController < ApplicationController
  def show
    @contests = current_user.guest? ? [] : Contest.open
  end
end
