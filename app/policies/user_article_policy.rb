class UserArticlePolicy < ApplicationPolicy
  
  def initialize(current_user, saved_aritcles)
    @current_user = current_user
    @saved_aritcles = saved_aritcles
  end

  def index?
    true
  end

  def create?
    present
  end

  def destroy?
    present
  end

  private

  def present
    @current_user.present?
  end
end