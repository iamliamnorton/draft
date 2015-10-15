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
    it "returns open contests" do
      open_contest = create(:contest)

      create(:contest_won)
      create(:contest_closed)

      aggregate_failures do
        expect(Contest.open).to include(open_contest)
        expect(Contest.open.count).to eq(1)
      end
    end
  end

  describe "#entries_remaining" do
    it "returns remaining entry count" do
      contest = create(:contest, max_entries: 3)
      create(:entry, contest: contest)

      expect(contest.entries_remaining).to eq(2)
    end
  end
end
