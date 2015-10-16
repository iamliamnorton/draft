require 'rails_helper'

RSpec.describe Sport, type: :model do
  describe "#valid?" do
    it { is_expected.to \
         validate_presence_of(:name) }

    it "factory is valid" do
      sport = create(:sport)

      expect(sport.valid?).to eq(true)
    end
  end
end
