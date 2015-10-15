require 'rails_helper'

RSpec.describe ContestsController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in(user) }

  let(:valid_attributes) {
    attributes_for(:contest)
  }

  let(:invalid_attributes) {
    attributes_for(:contest).merge(entry: 1)
  }

  describe "GET #show" do
    it "assigns the requested contest as @contest" do
      contest = user.contests.create! valid_attributes
      get :show, {id: contest.to_param}

      expect(assigns(:contest)).to eq(contest)
    end
  end

  describe "GET #new" do
    it "assigns a new contest as @contest" do
      get :new

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

      it "re-renders the 'new' template" do
        post :create, {contest: invalid_attributes}

        expect(response).to render_template("new")
      end
    end
  end
end
