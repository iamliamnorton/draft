require 'rails_helper'

RSpec.describe Draft::Score, type: :model do
  let(:contest) { create(:contest) }

  describe "#settle!" do
    let(:draft_score) { Draft::Score.new(contest: contest) }

    context "with a settled contest" do
      let(:contest) { create(:settled_contest) }

      it "raises an exception" do
        expect { draft_score.settle! }.to raise_error(ArgumentError)
      end
    end

    context "with unfinished games" do
      let!(:game) { create(:game, round: contest.round) }

      it "raises an exception" do
        expect { draft_score.settle! }.to raise_error(ArgumentError)
      end
    end

    context "with no contestants" do
      it "refunds the credits to the users account" do
        expect { draft_score.settle! }.
          to change { contest.user.credit }.
          by contest.entry * contest.max_entries
      end

      it "sets the contest #settled_at" do
        expect { draft_score.settle! }.
          to change { contest.settled_at }
      end
    end

    context "with contestants" do
      let!(:contestant) { create(:entry, contest: contest).user }

      context "when scores are drawn" do
        before { contestant }

        it "refunds credit to user" do
          expect { draft_score.settle! }.
            to change { contest.user.credit }.
            by contest.entry
        end

        it "refunds credit to contestant" do
          expect { draft_score.settle! }.
            to change { contestant.reload.credit }.
            by contest.entry
        end

        it "sets the contest #settled_at" do
          expect { draft_score.settle! }.
            to change { contest.settled_at }
        end
      end

      context "when there is a winner" do
        let!(:contestant) { create(:entry, contest: contest).user }
        let!(:roster) { create(:roster, contest: contest, user: contest.user) }

        let!(:game) { create(:completed_game, round: contest.round) }
        let!(:player) { create(:player, team: game.home_team) }
        let!(:draft_pick) { create(:draft_pick, roster: roster, player: player) }
        let!(:stat) { create(:stat, game: game, player: player) }

        it "awards credits to winner" do
          expect { draft_score.settle! }.
            to change { contest.user.credit }.
            by contest.prize
        end

        it "sets the contest #settled_at" do
          expect { draft_score.settle! }.
            to change { contest.settled_at }
        end
      end
    end
  end
end
