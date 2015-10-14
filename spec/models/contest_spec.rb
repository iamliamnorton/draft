require 'rails_helper'

RSpec.describe Contest, type: :model do
  describe "#valid?" do
    it { is_expected.to \
         validate_presence_of(:entry) }

    # TODO use validates_numericality_of when fixed

    it { is_expected.to \
         validate_presence_of(:cap) }
  end

  describe ".open" do
    it "returns open contests" do
      open_contest = create(:contest)

      create(:contest_won)
      create(:contest_closed)
      create(:contest_cancelled)

      aggregate_failures do
        expect(Contest.open).to include(open_contest)
        expect(Contest.open.count).to eq(1)
      end
    end
  end

  describe ".cancelled" do
    it "returns cancelled contests" do
      cancelled_contest = create(:contest_cancelled)

      create(:contest)
      create(:contest_won)
      create(:contest_closed)

      aggregate_failures do
        expect(Contest.cancelled).to include(cancelled_contest)
        expect(Contest.cancelled.count).to eq(1)
      end
    end
  end
end
