require 'rails_helper'

RSpec.describe "credit/show.html.erb", type: :view do
  it "renders" do
    user = create(:user)

    allow(view).to receive(:current_user) { user }

    render

    aggregate_failures do
      assert_select "h1", text: "Credit".to_s, count: 1
      assert_select "p", text: "Your credit balance is #{user.credit}".to_s, count: 1
    end
  end
end
