require 'rails_helper'

RSpec.describe AuthorizationsController, type: :controller do

  before { sign_in create(:user, password: "123456") }

  describe "GET /oauth/authorize" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /oauth/authorize" do
    it "returns http success" do
      post :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE /oauth/authorize/:id" do
    it "returns http success" do
      delete :destroy, params: { id: 1 }
      expect(response).to have_http_status(:success)
    end
  end

end
