require 'rails_helper'

RSpec.describe "Lobby", type: :request do
  describe "GET /lobby" do
    it "root ok" do
      get root_path

      expect(response).to have_http_status(200)
    end

    it "show ok" do
      get lobby_path

      expect(response).to have_http_status(200)
    end
  end
end
