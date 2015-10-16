require 'rails_helper'

RSpec.describe RosterSpot, type: :model do
  describe "#valid?" do
    it { is_expected.to \
         validate_presence_of(:cost) }

    it "factory is valid" do
      roster_spot = create(:roster_spot)

      expect(roster_spot.valid?).to eq(true)
    end
  end
end
