require 'rails_helper'

RSpec.describe "Lobby", type: :request do
  describe "Lobby" do
    it "ok for guest user" do
      get lobby_path

      expect(response).to have_http_status(200)
    end
  end
end
