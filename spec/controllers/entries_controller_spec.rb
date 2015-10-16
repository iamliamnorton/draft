require 'rails_helper'

RSpec.describe EntriesController, type: :controller do
  let(:contest) { create(:contest) }
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe "POST #create" do
    context "when joining a contest" do
      it "creates a new Entry" do
        expect {
          post :create, contest_id: contest.id
        }.to change(Entry, :count).by(1)
      end

      it "redirects to the contest" do
        post :create, contest_id: contest.id

        expect(response).to redirect_to(contest)
      end
    end

    context "when joining already entered contest" do
      before do
        create(:entry, user: user, contest: contest)
      end

      it "doesn't create a new Entry" do
        expect {
          post :create, contest_id: contest.id
        }.not_to change(Entry, :count)
      end

      it "redirects to the contest" do
        post :create, contest_id: contest.id

        expect(response).to redirect_to(contest)
      end
    end
  end
end
