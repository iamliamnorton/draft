require 'rails_helper'

RSpec.describe Roster, type: :model do
  describe "#valid?" do
    it "factory is valid" do
      roster = create(:roster)

      expect(roster.valid?).to eq(true)
    end
  end

  describe ".for_user" do
    it "returns rosters for user" do
      create(:roster)

      user = create(:user)
      user_roster = create(:roster, user: user)

      aggregate_failures do
        expect(Roster.for_user(user)).to include(user_roster)
        expect(Roster.for_user(user).count).to eq(1)
      end
    end
  end
end
