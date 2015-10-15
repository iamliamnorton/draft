require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe "#valid?" do
    it { is_expected.to \
         validate_presence_of(:credit) }

    it { is_expected.to \
         validate_presence_of(:email) }

    it { is_expected.to \
         validate_uniqueness_of(:email).
         case_insensitive }
  end

  describe "#involved_in?" do
    it "returns true for the contest owner" do
      contest = create(:contest, user: user)

      expect(user.involved_in?(contest)).to eq(true)
    end

    it "returns true for the a contestant" do
      contest = create(:entry, user: user).contest

      expect(user.involved_in?(contest)).to eq(true)
    end

    it "returns false for user who is neither the owner or a contestant" do
      contest = create(:contest)

      expect(user.involved_in?(contest)).to eq(false)
    end
  end

  describe "#can_enter?" do
    subject { user.can_enter?(contest) }

    context "as a user already involved in contest" do
      let(:contest) { create(:contest) }

      before {
        allow(user).to receive(:involved_in?).with(contest).and_return(true)
      }

      it { is_expected.to eq(false) }
    end

    context "for a contest with no remaining entries" do
      let(:contest) {
        create(:entry, contest: create(:contest, max_entries: 1)).contest
      }

      it { is_expected.to eq(false) }
    end

    context "for a contest with remaining entries and user not already involved" do
      let(:contest) { create(:contest) }

      it { is_expected.to eq(true) }
    end
  end

  describe "#guest?" do
    subject { user.guest? }

    it { is_expected.to eq(false) }
  end
end
