require 'rails_helper'

RSpec.describe ContestsController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in(user) }

  let(:valid_attributes) {
    { entry: 1_00 }
  }

  let(:invalid_attributes) {
    { entry: 1 }
  }

  describe "GET #show" do
    it "assigns the requested contest as @contest" do
      contest = Contest.create! valid_attributes
      get :show, {id: contest.to_param}

      expect(assigns(:contest)).to eq(contest)
    end
  end

  describe "GET #new" do
    it "assigns a new contest as @contest" do
      get :new, {}

      expect(assigns(:contest)).to be_a_new(Contest)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Contest" do
        expect {
          post :create, {contest: valid_attributes}
        }.to change(Contest, :count).by(1)
      end

      it "creates a new Entry" do
        expect {
          post :create, {contest: valid_attributes}
        }.to change(Entry, :count).by(1)
      end

      it "assigns a newly created contest as @contest" do
        post :create, {contest: valid_attributes}

        aggregate_failures do
          expect(assigns(:contest)).to be_a(Contest)
          expect(assigns(:contest)).to be_persisted
        end
      end

      it "redirects to the created contest" do
        post :create, {contest: valid_attributes}

        expect(response).to redirect_to(Contest.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved contest as @contest" do
        post :create, {contest: invalid_attributes}

        expect(assigns(:contest)).to be_a_new(Contest)
      end

      it "doesn't create a new Entry" do
        expect {
          post :create, {contest: invalid_attributes}
        }.not_to change(Entry, :count)
      end

      it "re-renders the 'new' template" do
        post :create, {contest: invalid_attributes}

        expect(response).to render_template("new")
      end
    end
  end

  describe "DELETE #destroy" do
    it "cancels the requested contest" do
      contest = Contest.create! valid_attributes
      expect {
        delete :destroy, {id: contest.to_param}
      }.to change {
        Contest.cancelled.count
      }.by(1)
    end

    it "redirects to the lobby" do
      contest = Contest.create! valid_attributes
      delete :destroy, {id: contest.to_param}

      expect(response).to redirect_to(lobby_url)
    end
  end
end
