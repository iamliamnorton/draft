require "rails_helper"

RSpec.describe CreditController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(:get => "/credit").to route_to("credit#show")
    end

    it "routes to #create" do
      expect(:post => "/credit").to route_to("credit#create")
    end
  end
end
