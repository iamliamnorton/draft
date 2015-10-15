require 'rails_helper'

RSpec.describe "Resetting password", type: :feature do
  it "user can send password reset instructions and reset password" do
    user = create(:user)
    visit new_user_session_path

    click_link 'Forgot your password?'
    expect(page).to have_content 'Forgot your password?'

    fill_in 'Email', with: 'invalid@email.add'

    click_button 'Send me reset password instructions'
    expect(page).to have_content 'Email not found'

    fill_in 'Email', with: user.email

    click_button 'Send me reset password instructions'
    expect(page).to have_content 'You will receive an email with instructions'

    # fake token lookup
    allow(User).to receive(:with_reset_password_token) { user }

    # fake email link click
    visit edit_user_password_url(reset_password_token: 'faked-token')

    expect(page).to have_content 'Change your password'

    fill_in 'New password', with: 'newpassword'
    fill_in 'Confirm new password', with: 'newpassword'

    # fake token lookup
    allow(User).to receive(:find_or_initialize_with_error_by) { user }
    allow(user).to receive(:reset_password_period_valid?) { true }

    click_button 'Change my password'
    expect(page).to have_content 'Your password has been changed successfully.'
    expect(page).to have_content 'You are now signed in.'
  end
end
