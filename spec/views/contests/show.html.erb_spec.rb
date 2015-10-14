require 'rails_helper'

RSpec.describe "contests/show", type: :view do
  before do
    @contest = assign(
      :contest, create(:contest,
        entry: 100_000,
        cap: 200
    ))
  end

  it "renders attributes in <p>" do
    render

    aggregate_failures do
      expect(rendered).to match(/10000/)
      expect(rendered).to match(/200/)
    end
  end
end
