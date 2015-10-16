require 'rails_helper'

RSpec.describe Roster, type: :model do
  describe "#valid?" do
    it "factory is valid" do
      roster = create(:roster)

      expect(roster.valid?).to eq(true)
    end
  end
end
