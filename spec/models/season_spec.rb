require 'rails_helper'

RSpec.describe Season, type: :model do
  describe "#valid?" do
    it { is_expected.to \
         validate_presence_of(:name) }

    it { is_expected.to \
         validate_presence_of(:year) }

    it { is_expected.to \
         validate_presence_of(:max_draft_picks) }

    it "factory is valid" do
      season = create(:season)

      expect(season.valid?).to eq(true)
    end
  end
end
