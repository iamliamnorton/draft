require 'rails_helper'

RSpec.describe "Signing up", type: :feature do
  it "user can sign up and confirm email" do
    user = build(:user)
    visit root_path

    click_link 'Sign in'
    expect(page).to have_content 'Remember me'

    click_link 'Sign up'
    expect(page).to have_content 'Sign up'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: "bad-password"
    fill_in 'Password confirmation', with: "password"

    click_button 'Sign up'
    expect(page).to have_content "Password confirmation doesn't match Password"

    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"

    click_button 'Sign up'
    expect(page).to have_content 'Please follow the link to activate your account.'

    click_link 'Sign in'
    expect(page).to have_content 'Remember me'

    click_link 'Sign in'
    click_link "Didn't receive confirmation instructions?"
    expect(page).to have_content "Resend confirmation instructions"

    fill_in 'Email', with: "unknown@email.address"

    click_button 'Resend confirmation instructions'
    expect(page).to have_content 'Email not found'

    fill_in 'Email', with: user.email

    click_button 'Resend confirmation instructions'
    expect(page).to have_content 'You will receive an email with instructions'

    # fake token lookup
    user = User.find_by_email(user.email)
    allow(User).to receive(:find_first_by_auth_conditions) { user }

    # fake email link click
    visit user_confirmation_url(confirmation_token: 'faked-token')

    expect(page).to have_content 'Your email address has been successfully confirmed.'
  end
end
