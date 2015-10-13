require 'rails_helper'

RSpec.describe "lobby/show.html.erb", type: :view do
  it "renders" do
    render

    aggregate_failures do
      assert_select "h1", text: "Lobby".to_s, count: 1
      assert_select "p", text: "Welcome".to_s, count: 1
    end
  end

  it "renders user data" do
    user = create(:user)
    sign_in(user)

    render

    aggregate_failures do
      assert_select "h1", text: "Lobby".to_s, count: 1
      assert_select "p", text: "Welcome #{user.email}".to_s, count: 1
    end
  end
end
