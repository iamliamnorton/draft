require 'rails_helper'

RSpec.describe Stat, type: :model do
  describe "#valid?" do
    it { is_expected.to \
         validate_presence_of(:points) }

    it "factory is valid" do
      stat = create(:stat)

      expect(stat.valid?).to eq(true)
    end
  end
end
