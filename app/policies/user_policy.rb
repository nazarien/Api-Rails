class UserPolicy < ApplicationPolicy

  def initialize(current_user, article)
    @current_user = current_user
    @article = article
  end

  def index 
    true
  end

  def show?
    author
  end    

  def create?
    author
  end

  def update?
    author
  end

  def destroy?
    author
  end

  private

  def author
    @current_user.author?    
  end
end