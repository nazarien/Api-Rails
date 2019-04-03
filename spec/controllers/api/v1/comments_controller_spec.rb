require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do
  before(:each) do
    @user = create(:user)
    @comment_for_article = create(:comment, :for_article)
    @comment_for_user = create(:comment, :for_user)
    auth_headers = @user.create_new_auth_token
    setting_headers(auth_headers)
  end

  describe "create action" do
    it "comment for user: returns 201 - saved and has correct params" do
      post :create, params: { comment: { commenter: @comment_for_user.commenter, body: @comment_for_user.body, commentable_type: @comment_for_user.commentable_type, commentable_id: @comment_for_user.commentable_id } }
      hash_body = JSON.parse(response.body)
      expect(hash_body["id"]).to match(Comment.last.id)
      expect(response).to have_http_status(201)
    end

    it "comment for article: returns 201 - saved and has correct params" do
      post :create, params: { comment: { commenter: @comment_for_article.commenter, body: @comment_for_article.body, commentable_type: @comment_for_article.commentable_type, commentable_id: @comment_for_article.commentable_id } }
      hash_body = JSON.parse(response.body)
      expect(hash_body["id"]).to match(Comment.last.id)
      expect(response).to have_http_status(201)
    end

    it "not create comment on article if commenter or body nil" do
      post :create, params: { comment: { commenter: @comment_for_article.commenter, body: nil, commentable_type: @comment_for_article.commentable_type, commentable_id: @comment_for_article.commentable_id } }
      expect(response).to have_http_status(422)
    end
  end 

  describe "destroy action will" do
    before(:each) do
      @user = create(:user)
      @article = create(:article)
      @comment_for_article = create(:comment, :for_article, commenter: @user.email)
      @comment_for_user = create(:comment, :for_user, commenter: @user.email)
      auth_headers = @user.create_new_auth_token
      setting_headers(auth_headers)
    end
    
    it "delete user comment" do
      delete :destroy, params: { id: @comment_for_user.id }
      expect(response).to have_http_status(204)
    end

    it " can`t delete comment if commenter != user.email" do
      comment_for_user = create(:comment, :for_user)
      delete :destroy, params: { id: comment_for_user.id }
      expect(response).to have_http_status(403)
    end

    it "delete article comment" do
      delete :destroy, params: { id:@comment_for_article.id }
      expect(response).to have_http_status(204)
    end
  end
end

def setting_headers(auth_headers)
  auth_headers.each do |key, value|
    request.headers[key] = value
  end
end