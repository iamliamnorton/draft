require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe "#valid?" do
    it { is_expected.to \
         validate_presence_of(:user) }

    it { is_expected.to \
         validate_presence_of(:contest) }

    it "factory is valid" do
      entry = create(:entry)

      expect(entry.valid?).to eq(true)
    end
  end
end
