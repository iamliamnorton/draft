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

  describe ".incomplete" do
    it "returns incomplete rounds" do
      completed_round = create(:completed_round)

      create(:round)
      create(:closed_round)

      aggregate_failures do
        expect(Round.incomplete).not_to include(completed_round)
        expect(Round.incomplete.count).to eq(2)
      end
    end
  end

  describe ".open" do
    it "returns open rounds" do
      open_round = create(:round)

      create(:closed_round)
      create(:completed_round)

      aggregate_failures do
        expect(Round.open).to include(open_round)
        expect(Round.open.count).to eq(1)
      end
    end
  end

  describe ".closed" do
    it "returns closed rounds" do
      closed_round = create(:closed_round)

      create(:round)
      create(:completed_round)

      aggregate_failures do
        expect(Round.closed).to include(closed_round)
        expect(Round.closed.count).to eq(1)
      end
    end
  end

  describe "#open?" do
    subject { round.open? }

    context "for open rounds" do
      let(:round) { create(:round) }

      it { is_expected.to eq(true) }
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

  describe "#running?" do
    subject { round.running? }

    context "for open rounds" do
      let(:round) { create(:round) }

      it { is_expected.to eq(false) }
    end

    context "for closed rounds" do
      let(:round) { create(:closed_round) }

      it { is_expected.to eq(true) }
    end

    context "for completed rounds" do
      let(:round) { create(:completed_round) }

      it { is_expected.to eq(false) }
    end
  end

  describe "#completed?" do
    subject { round.completed? }

    context "for open rounds" do
      let(:round) { create(:round) }

      it { is_expected.to eq(false) }
    end

    context "for closed rounds" do
      let(:round) { create(:closed_round) }

      it { is_expected.to eq(false) }
    end

    context "for completed rounds" do
      let(:round) { create(:completed_round) }

      it { is_expected.to eq(true) }
    end
  end
end
