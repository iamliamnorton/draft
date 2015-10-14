require 'rails_helper'

RSpec.describe "Lobby", type: :request do
  describe "Lobby" do
    it "show ok for guest" do
      get lobby_path

      expect(response).to have_http_status(200)
    end

    skip "shows contests for signed in user" do
      # needs devise login for request specs
    end
  end
end
