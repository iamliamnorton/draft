require 'rails_helper'

RSpec.describe "Edit profile", type: :feature do
  it "user can edit profile details" do
    user = create(:user)
    sign_in(user)

    visit edit_user_registration_path

    expect(page).to have_content 'Edit User'

    fill_in 'Email', with: 'new@email.address'

    click_button 'Update'
    expect(page).to have_content "Current password can't be blank"

    fill_in 'Current password', with: 'password'

    click_button 'Update'
    expect(page).to have_content "You updated your account successfully"
    expect(page).to have_content "but we need to verify your new email address."
  end
end
