require 'rails_helper'

RSpec.describe "lobby/show.html.erb", type: :view do
  it "renders" do
    render

    aggregate_failures do
      assert_select "h1", text: "Lobby".to_s, count: 1
    end
  end
end
