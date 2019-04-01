class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: comment, status: :success
  end
  
  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment, status: :success
    else
      render json: comment, status: :unprocessable_entity
    end
  end

  private
  
  def comment_params
    params.require(:comment).permit(:commenter, :body, :commentable_id, :commentable_type)
  end
end
