require 'rails_helper'

RSpec.describe ContestEntryForm, type: :model do
  let(:user) { create(:user) }
  let(:contest) { create(:contest) }

  let(:contest_entry_form) {
    described_class.new(
      user: user,
      contest: contest
    )
  }

  describe "#save" do
    it "creates an entry" do
      expect { contest_entry_form.save }.to \
        change { Entry.count }.
        by +1
    end

    it "adjusts users credit" do
      expect { contest_entry_form.save }.to \
        change { user.credit }.
        by -contest.entry
    end
  end

  describe "#valid?" do
    subject { contest_entry_form.valid? }

    context "with defaults" do
      it { is_expected.to eq(true) }
    end

    context "with insufficient credit" do
      let(:user) { create(:user, credit: 99) }

      it { is_expected.to eq(false) }
    end

    context "as the contest owner" do
      let(:user) { contest.user }

      it { is_expected.to eq(false) }
    end

    context "as a current contestant" do
      let(:user) { create(:entry, contest: contest).user }

      it { is_expected.to eq(false) }
    end

    context "when max contestants reached" do
      before { contest.max_entries = 0 }

      it { is_expected.to eq(false) }
    end
  end
end
