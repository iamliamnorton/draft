require 'rails_helper'

RSpec.describe "Contests", type: :request do
  describe "GET contests#show" do
    it "redirects guest user" do
      contest = create(:contest)

      get contest_path(contest)

      expect(response).to have_http_status(302)

      follow_redirect!

      expect(response).to render_template('devise/sessions/new')
      expect(response.body).to \
        include("You need to sign in or sign up before continuing.")
    end
  end

  describe "GET contests#new" do
    it "redirects guest user" do
      get new_contest_path

      expect(response).to have_http_status(302)

      follow_redirect!

      expect(response).to render_template('devise/sessions/new')
      expect(response.body).to \
        include("You need to sign in or sign up before continuing.")
    end
  end

  describe "POST contests#create" do
    it "redirects guest user" do
      post contests_path

      expect(response).to have_http_status(302)

      follow_redirect!

      expect(response).to render_template('devise/sessions/new')
      expect(response.body).to \
        include("You need to sign in or sign up before continuing.")
    end
  end
end
