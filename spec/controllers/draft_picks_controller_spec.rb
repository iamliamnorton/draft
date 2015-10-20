require 'rails_helper'

RSpec.describe DraftPicksController, type: :controller do
  let(:user) { contest.user }
  let(:player) { create(:player, team: team) }
  let(:contest) { create(:contest) }

  let!(:team) { create(:team) }
  let!(:game) { create(:game, home_team: team, round: contest.round) }

  before { sign_in(user) }

  describe "POST #create" do
    context "when drafting a player" do
      it "creates a new DraftPick" do
        expect {
          post :create, contest_id: contest.id, player_id: player.id
        }.to change(DraftPick, :count).by(1)
      end

      it "redirects to the contest" do
        post :create, contest_id: contest.id, player_id: player.id

        expect(response).to redirect_to(contest)
      end
    end

    context "when drafting duplicate" do
      before do
        create(
          :draft_pick,
          player: player,
          roster: create(:roster, user: user, contest: contest)
        )
      end

      it "doesn't create a new DraftPick" do
        expect {
          post :create, contest_id: contest.id, player_id: player.id
        }.not_to change(DraftPick, :count)
      end

      it "redirects to the contest" do
        post :create, contest_id: contest.id, player_id: player.id

        expect(response).to redirect_to(contest)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:draft_pick) { create(
      :draft_pick,
      player: player,
      roster: create(:roster, user: user, contest: contest)
    ) }

    context "when deleting a draft_pick" do
      it "destroys a DraftPick" do
        expect {
          delete :destroy, contest_id: contest.id, id: draft_pick.id
        }.to change(DraftPick, :count).by(-1)
      end

      it "redirects to the contest" do
        delete :destroy, contest_id: contest.id, id: draft_pick.id

        expect(response).to redirect_to(contest)
      end
    end

    context "when deleting a not owned draft_pick" do
      before {
        sign_in(create(:user))
      }

      it "doesn't destroy a DraftPick" do
        expect {
          delete :destroy, contest_id: contest.id, id: draft_pick.id
        }.not_to change(DraftPick, :count)
      end

      it "redirects to the contest" do
        delete :destroy, contest_id: contest.id, id: draft_pick.id

        expect(response).to redirect_to(contest)
      end
    end
  end
end
