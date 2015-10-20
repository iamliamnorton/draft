require 'rails_helper'

RSpec.describe Contest, type: :model do
  describe "#valid?" do
    it { is_expected.to \
         validate_presence_of(:entry) }

    it { is_expected.to \
         validate_presence_of(:salary_cap) }

    it { is_expected.to \
         validate_presence_of(:min_entries) }

    it { is_expected.to \
         validate_presence_of(:max_entries) }

    it "factory is valid" do
      contest = create(:contest)

      expect(contest.valid?).to eq(true)
    end
  end

  describe ".open" do
    it "returns contests in open rounds" do
      create(:contest, round: create(:closed_round))
      create(:contest, round: create(:completed_round))

      open_contest = create(:contest)

      aggregate_failures do
        expect(Contest.open).to include(open_contest)
        expect(Contest.open.count).to eq(1)
      end
    end
  end

  describe "#settled?" do
    subject { contest.settled? }

    context "for settled contests" do
      let(:contest) { create(:settled_contest) }

      it { is_expected.to eq(true) }
    end

    context "for unsettled contests" do
      let(:contest) { create(:contest) }

      it { is_expected.to eq(false) }
    end
  end

  describe "#prize?" do
    subject { contest.prize }

    context "it takes a cut (10%)" do
      let(:contest) { create(:contest, entry: 100) }

      it { is_expected.to eq(180) }
    end

    context "rounds down to a whole number (Integer)" do
      let(:contest) { create(:contest, entry: 101) }

      it { is_expected.to eq(181) }
    end
  end
end
