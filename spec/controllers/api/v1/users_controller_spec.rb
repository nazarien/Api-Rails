require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  describe "GET #index" do
    it "returns http success on index" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "routing" do
    it "routes to #index" do
      expect(get: 'api/v1/users').to route_to(controller: 'api/v1/users', action: 'index')
    end
  end

  describe "GET #show" do
    it "returns http success on show" do
      user = create(:user)
      auth_headers = user.create_new_auth_token
      setting_headers(auth_headers)
      get :show, params: { id: user.id }
      hash_body = JSON.parse(response.body)
      expect(hash_body["id"]).to eq(User.last.id)
    end
  end

  describe "routing" do
    it "routes to #show" do
      expect(get: '/api/v1/users/1').to route_to(controller: 'api/v1/users', action: 'show', id: '1')
    end
  end

end

def setting_headers(auth_headers)
  auth_headers.each do |key, value|
    request.headers[key] = value
  end
end