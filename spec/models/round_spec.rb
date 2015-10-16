require 'rails_helper'

RSpec.describe Round, type: :model do
  describe "#valid?" do
    it { is_expected.to \
         validate_presence_of(:name) }
  end

  describe ".opened" do
    it "returns opened rounds" do
      opened_round = create(:round)
      closed_round = create(:closed_round)

      create(:pending_round)

      aggregate_failures do
        expect(Round.opened).to include(opened_round)
        expect(Round.opened).to include(closed_round)
        expect(Round.opened.count).to eq(2)
      end
    end
  end

  describe ".open" do
    it "returns opened rounds that haven't closed" do
      open_round = create(:round)

      create(:closed_round)
      create(:pending_round)

      aggregate_failures do
        expect(Round.open).to include(open_round)
        expect(Round.open.count).to eq(1)
      end
    end
  end
end
