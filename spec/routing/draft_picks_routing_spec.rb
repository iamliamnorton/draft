require "rails_helper"

RSpec.describe DraftPicksController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(:post => "contests/1/draft_picks").to \
        route_to("draft_picks#create", contest_id: "1")
    end

    it "routes to #destroy" do
      expect(:delete => "contests/1/draft_picks/1").to \
        route_to("draft_picks#destroy", contest_id: "1", id: "1")
    end
  end
end
