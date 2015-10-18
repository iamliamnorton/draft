require 'rails_helper'

RSpec.describe CreateDraftPicksForm, type: :model do
  let(:user) { contest.user }
  let(:player) { create(:player, team: team) }
  let(:contest) { create(:contest) }

  let!(:team) { create(:team) }
  let!(:game) { create(:game, team: team, round: contest.round) }

  let(:create_draft_picks_form) {
    described_class.new(
      user: user,
      player: player,
      contest: contest
    )
  }

  describe "#save" do
    it "creates a roster spot" do
      expect { create_draft_picks_form.save }.to \
        change { DraftPick.count }.
        by +1
    end
  end

  describe "#valid?" do
    subject { create_draft_picks_form.valid? }

    context "as contest owner" do
      it { is_expected.to eq(true) }
    end

    context "as contestant" do
      let(:user) { create(:entry, contest: contest).user }

      it { is_expected.to eq(true) }
    end

    context "as non-member" do
      let(:user) { create(:user) }

      it { is_expected.to eq(false) }
    end

    context "for a contest in a closed round" do
      let(:contest) { create(:closed_contest) }

      it { is_expected.to eq(false) }
    end

    context "adding a player not available in round" do
      let(:player) { create(:player) }

      it { is_expected.to eq(false) }
    end

    context "when the salary cap would be exceeded" do
      before { create(
        :draft_pick,
        roster: create(:roster, user: user, contest: contest),
        cost: contest.salary_cap
      ) }

      it { is_expected.to eq(false) }
    end

    context "when the max players for sport exceeded" do # TODO class per sport for rules
      before {
        roster = create(:roster, user: user, contest: contest)
        10.times {
          create(:draft_pick, roster: roster)
        }
      }

      it { is_expected.to eq(false) }
    end
  end
end
