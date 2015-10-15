require "rails_helper"

RSpec.describe EntriesController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(:post => "contests/1/entries").to route_to("entries#create", contest_id: "1")
    end
  end
end
