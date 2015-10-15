require 'rails_helper'

RSpec.describe "Entries", type: :request do
  describe "POST entries#create" do
    it "redirects guest user" do
      contest = create(:contest)

      post contest_entries_path(contest)

      expect(response).to have_http_status(302)

      follow_redirect!

      expect(response).to render_template('devise/sessions/new')
      expect(response.body).to \
        include("You need to sign in or sign up before continuing.")
    end
  end
end
