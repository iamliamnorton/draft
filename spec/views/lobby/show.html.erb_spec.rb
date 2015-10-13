require 'rails_helper'

RSpec.describe "lobby/show.html.erb", type: :view do
  it "renders with guest" do
    allow(view).to receive(:current_user) { Guest.new }

    render

    aggregate_failures do
      assert_select "h1", text: "Lobby".to_s, count: 1
      assert_select "p", text: "Welcome".to_s, count: 1
    end
  end

  it "renders with user" do
    user = create(:user)

    allow(view).to receive(:current_user) { user }

    render

    aggregate_failures do
      assert_select "h1", text: "Lobby".to_s, count: 1
      assert_select "p", text: "Welcome #{user.email}".to_s, count: 1
    end
  end
end
