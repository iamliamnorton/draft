require 'rails_helper'

RSpec.describe CreateContestsForm, type: :model do
  let(:user) { create(:user) }
  let(:contest) { build(:contest) }

  let(:create_contests_form) {
    described_class.new(
      user: user,
      contest: contest
    )
  }

  describe "#save" do
    it "creates a contest" do
      expect { create_contests_form.save }.to \
        change { Contest.count }.
        by +1
    end

    it "adjusts users credit" do
      expect { create_contests_form.save }.to \
        change { user.credit }.
        by -(contest.entry * contest.max_entries)
    end
  end

  describe "#valid?" do
    subject { create_contests_form.valid? }

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

    context "for a contest in a closed round" do
      let(:contest) { create(:closed_contest) }

      it { is_expected.to eq(false) }
    end
  end
end
