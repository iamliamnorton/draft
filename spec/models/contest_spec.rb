require 'rails_helper'

RSpec.describe Contest, type: :model do
  describe "#valid?" do
    it { is_expected.to \
         validate_presence_of(:entry) }

    it { is_expected.to \
         validate_presence_of(:cap) }

    it { is_expected.to \
         validate_presence_of(:min_entries) }

    it { is_expected.to \
         validate_presence_of(:max_entries) }
  end

  describe ".open" do
    it "returns contests in open rounds" do
      past_contest = create(:contest, round: create(:closed_round))

      open_contest = create(:contest)

      aggregate_failures do
        expect(Contest.open).to include(open_contest)
        expect(Contest.open.count).to eq(1)
      end
    end
  end
end
