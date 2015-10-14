require "rails_helper"

RSpec.describe ContestsController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(:get => "/contests/new").to route_to("contests#new")
    end

    it "routes to #show" do
      expect(:get => "/contests/1").to route_to("contests#show", id: "1")
    end

    it "routes to #create" do
      expect(:post => "/contests").to route_to("contests#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/contests/1").to route_to("contests#destroy", id: "1")
    end
  end
end
