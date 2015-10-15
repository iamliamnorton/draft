require 'rails_helper'

RSpec.describe "Credit", type: :request do
  describe "GET credit#show" do
    it "redirects guest user" do
      get credit_path

      expect(response).to have_http_status(302)

      follow_redirect!

      expect(response).to render_template('devise/sessions/new')
      expect(response.body).to \
        include("You need to sign in or sign up before continuing.")
    end
  end

  describe "POST credit#create" do
    it "redirects guest user" do
      post credit_path

      expect(response).to have_http_status(302)

      follow_redirect!

      expect(response).to render_template('devise/sessions/new')
      expect(response.body).to \
        include("You need to sign in or sign up before continuing.")
    end
  end
end
