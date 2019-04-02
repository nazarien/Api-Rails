class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    comment = Comment.find(params[:id])
    authorize comment

    comment.destroy
    render json: comment, status: 200
  end
  
  def create
    comment = Comment.new(comment_params)
    authorize comment

    if comment.save
      render json: comment, status: 200
    else
      render json: comment, status: 500
    end
  end

  private
  
  def comment_params
    params.require(:comment).permit(:commenter, :body, :commentable_id, :commentable_type)
  end
end
