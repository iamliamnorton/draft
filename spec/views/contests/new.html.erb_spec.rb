require 'rails_helper'

RSpec.describe "contests/new", type: :view do
  before do
    assign(:contest, build(:contest))
  end

  it "renders new contest form" do
    render

    aggregate_failures do
      assert_select "form[action=?][method=?]", contests_path, "post" do
        assert_select "input#contest_entry[name=?]", "contest[entry]"
        assert_select "input#contest_cap[name=?]", "contest[cap]"
      end
    end
  end
end
