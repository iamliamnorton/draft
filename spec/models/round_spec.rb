require 'rails_helper'

RSpec.describe Round, type: :model do
  describe "#valid?" do
    it { is_expected.to \
         validate_presence_of(:name) }

    it "factory is valid" do
      round = create(:round)

      expect(round.valid?).to eq(true)
    end
  end

  describe ".opened" do
    it "returns opened rounds" do
      opened_round = create(:round)
      closed_round = create(:closed_round)
      completed_round = create(:completed_round)

      create(:pending_round)

      aggregate_failures do
        expect(Round.opened).to include(opened_round)
        expect(Round.opened).to include(closed_round)
        expect(Round.opened).to include(completed_round)
        expect(Round.opened.count).to eq(3)
      end
    end
  end

  describe ".open" do
    it "returns open rounds" do
      open_round = create(:round)

      create(:pending_round)
      create(:closed_round)
      create(:completed_round)

      aggregate_failures do
        expect(Round.open).to include(open_round)
        expect(Round.open.count).to eq(1)
      end
    end
  end

  describe "#open?" do
    subject { round.open? }

    context "for open rounds" do
      let(:round) { create(:round) }

      it { is_expected.to eq(true) }
    end

    context "for pending rounds" do
      let(:round) { create(:pending_round) }

      it { is_expected.to eq(false) }
    end

    context "for closed rounds" do
      let(:round) { create(:closed_round) }

      it { is_expected.to eq(false) }
    end

    context "for completed rounds" do
      let(:round) { create(:completed_round) }

      it { is_expected.to eq(false) }
    end
  end
end
