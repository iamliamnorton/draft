require "rails_helper"

RSpec.describe LobbyController, type: :routing do
  describe "routing" do
    it "root routes to #show" do
      expect(:get => "/").to route_to("lobby#show")
    end

    it "routes to #show" do
      expect(:get => "/lobby").to route_to("lobby#show")
    end
  end
end
