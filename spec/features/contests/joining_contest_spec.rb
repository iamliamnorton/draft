require 'rails_helper'

RSpec.describe "Joining contest", type: :feature do
  it "user can join a contest" do
    contest = create(:contest)

    sign_in

    visit lobby_path

    click_link 'View'

    click_link 'Join'

    expect(page).to have_content "Contest was successfully joined."
  end
end
