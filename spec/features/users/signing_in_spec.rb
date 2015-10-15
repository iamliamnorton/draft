require 'rails_helper'

RSpec.describe "Signing in", type: :feature do
  it "user can sign in and out" do
    user = create(:user)
    visit root_path

    click_link 'Sign in'
    expect(page).to have_content 'Remember me'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: "not-my-password"

    click_button 'Sign in'
    expect(page).to have_content 'Invalid email or password.'

    fill_in 'Password', with: "password"

    click_button 'Sign in'
    expect(page).to have_content 'Signed in successfully.'

    click_link user.email
    click_link 'Sign out'
    expect(page).to have_content 'Signed out successfully.'
  end
end
