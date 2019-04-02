class CommentPolicy < ApplicationPolicy

  def initialize(current_user, comment)
    @current_user = current_user
    @comment = comment
  end

  def index 
    true
  end 

  def create?
    @current_user.present?
  end
  
  def destroy?
    @current_user.present? && @current_user.email == @comment.commenter
  end    
end