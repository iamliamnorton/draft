require 'rails_helper'

RSpec.describe "DraftPicks", type: :request do
  describe "POST draft_picks#create" do
    it "redirects guest user" do
      contest = create(:contest)

      post contest_draft_picks_path(contest)

      expect(response).to have_http_status(302)

      follow_redirect!

      expect(response).to render_template('devise/sessions/new')
      expect(response.body).to \
        include("You need to sign in or sign up before continuing.")
    end
  end

  describe "DELETE draft_picks#destroy" do
    it "redirects guest user" do
      contest = create(:contest)
      roster = create(:roster)

      delete contest_draft_pick_path(contest, roster)

      expect(response).to have_http_status(302)

      follow_redirect!

      expect(response).to render_template('devise/sessions/new')
      expect(response.body).to \
        include("You need to sign in or sign up before continuing.")
    end
  end
end
