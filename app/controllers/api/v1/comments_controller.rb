class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    comment = Comment.find(params[:id])
    authorize comment

    comment.destroy
    render json: comment, status: 204
  end
  
  def create
    comment = Comment.new(comment_params)
    authorize comment

    if comment.save
      render json: comment, status: 201
    else
      render json: comment, status: 422
    end
  end

  private
  
  def comment_params
    params.require(:comment).permit(:commenter, :body, :commentable_id, :commentable_type)
  end
end
