require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, type: :controller do
  describe "GET #index" do
    before(:each) do
      @article = create(:article)
      get :index
    end
    
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON body response contains expected recipe attributes" do
      hash_body = JSON.parse(response.body)
      expect(hash_body.count).to eql(Article.count)
    end
  end

  describe "show action" do
    before(:each) do
      @article = create(:article)
    end

    it "returns http forbbiden if user not present" do
      get :show, params: { id: @article.id }
      expect(response).to have_http_status(401)
    end    

    it "returns 200 if user present" do
      auth_headers = @article.user.create_new_auth_token
      setting_headers(auth_headers)
      get :show, params: { id: @article.id }
      expect(response).to have_http_status(200)
    end  
  end

  describe "create action" do
    before(:each) do
      @article = create(:article)
      auth_headers = @article.user.create_new_auth_token
      setting_headers(auth_headers)
    end

    it "returns 201 - saved" do
      post :create, params: { article: { title: 'name !', text: 'article', id: @article.id } } 
      hash_body = JSON.parse(response.body)
      expect(hash_body["id"]).to eq(Article.last.id)
      expect(response).to have_http_status(201)
    end

    it "returns 422 - didn't save" do
      post :create, params: { article: { title: nil, text: nil } } 
      expect(response).to have_http_status(422)
    end
  end 

  describe "destroy action" do
    it "returns 204 if article was delited - deleted" do
      @article = create(:article)
      auth_headers = @article.user.create_new_auth_token
      setting_headers(auth_headers)
      delete :destroy, params: { id: @article.id }
      expect(response).to have_http_status(204)

    end
  end

  describe "update action" do
    it "returns 204 if articles was updated - updated" do
      @article = create(:article)
      auth_headers = @article.user.create_new_auth_token
      setting_headers(auth_headers)
      put :update, params: { article: { title: 'some title', text: 'text' }, id: @article.id}
      expect(response).to have_http_status(204)
    end
  end
end

def setting_headers(auth_headers)
  auth_headers.each do |key, value|
    request.headers[key] = value
  end
end