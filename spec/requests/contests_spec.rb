require 'rails_helper'

RSpec.describe "Contests", type: :request do
  describe "Creating a new contest" do
    it "redirect for guest" do
      get new_contest_path

      expect(response).to have_http_status(302)
    end

    skip "signed in user uses contests " do
      # needs devise login for request specs
    end
  end
end
