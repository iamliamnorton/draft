require 'rails_helper'

RSpec.describe ContestCreationForm, type: :model do
  let(:user) { create(:user) }
  let(:rounds) { [contest.round] }
  let(:contest) { build(:contest) }

  let(:contest_creation_form) {
    described_class.new(
      user: user,
      rounds: rounds,
      contest: contest
    )
  }

  describe "#save" do
    it "creates a contest" do
      expect { contest_creation_form.save }.to \
        change { Contest.count }.
        by +1
    end

    it "adjusts users credit" do
      expect { contest_creation_form.save }.to \
        change { user.credit }.
        by -(contest.entry * contest.max_entries)
    end
  end

  describe "#valid?" do
    subject { contest_creation_form.valid? }

    context "with defaults" do
      it { is_expected.to eq(true) }
    end

    context "with insufficient credit" do
      let(:user) { create(:user, credit: 99) }

      it { is_expected.to eq(false) }
    end

    context "with an invalid contest" do
      let(:contest) { build(:contest, entry: nil) }

      it { is_expected.to eq(false) }
    end

    context "with an invalid round" do
      let(:rounds) { [create(:round)] }

      it { is_expected.to eq(false) }
    end
  end
end
