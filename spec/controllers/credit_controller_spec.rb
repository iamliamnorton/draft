require 'rails_helper'

RSpec.describe CreditController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe "GET #show" do
    it "returns http success" do
      get :show

      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    let(:valid_attributes) {
      { user: { credit: "123" } }
    }

    let(:invalid_attributes) {
      { user: { credit: nil } }
    }

    context "with valid params" do
      it "adds user credit" do
        expect { post :create, valid_attributes }.
          to change { user.reload.credit }.
          to 123
      end

      it "redirects to the lobby" do
        post :create, valid_attributes

        expect(response).to redirect_to(lobby_path)
      end
    end

    context "with invalid params" do
      it "doesn't add user credit" do
        expect { post :create, invalid_attributes }.
          not_to change { user.reload.credit }
      end

      it "re-renders the 'show' template" do
        post :create, invalid_attributes

        expect(response).to render_template("show")
      end
    end
  end
end
