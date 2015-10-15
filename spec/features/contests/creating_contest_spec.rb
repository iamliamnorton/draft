require 'rails_helper'

RSpec.describe "Creating contest", type: :feature do
  it "user can create a contest" do
    sign_in

    visit lobby_path

    click_link 'Create contest'
    expect(page).to have_content "New Contest"

    click_button 'Create contest'
    expect(page).to have_content "Entry can't be blank"

    fill_in 'Entry', with: 1_00
    fill_in 'Max entries', with: 100

    click_button 'Create contest'
    expect(page).to have_content "Contest was successfully created."
  end
end