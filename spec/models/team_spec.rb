require 'rails_helper'

RSpec.describe Team, type: :model do
  describe "#valid?" do
    it { is_expected.to \
         validate_presence_of(:name) }

    it "factory is valid" do
      team = create(:team)

      expect(team.valid?).to eq(true)
    end
  end
end
