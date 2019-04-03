require 'rails_helper'

RSpec.describe Api::V1::UserArticlesController, type: :controller do
  before (:each) do 
    @user = create(:user)
    @article = create(:article)
    auth_headers = @user.create_new_auth_token
    setting_headers(auth_headers)
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      post :create, params: { id: @article.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      delete :destroy, params: { id: @article.id }
      expect(response).to have_http_status(:success)
    end
  end
end

def setting_headers(auth_headers)
  auth_headers.each do |key, value|
    request.headers[key] = value
  end
end