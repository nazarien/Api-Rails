class Api::V1::UserArticlesController < ApplicationController
  def index
    @saved_aritcles = current_user.favorite_articles

    render json: @saved_aritcles, status: 200
  end

  def create
    @favorite_article = current_user.user_articles.new(article_id: find_article.id)
    authorize @favorite_article
    @favorite_article.save

    render json: @favorite_article, status: 200
  end

  def destroy
    authorize current_user
    current_user.favorite_articles.delete(find_article)
  end

  private

  def parametrs
    params.permit(:id)
  end

  def find_article
    @article ||= Article.find(parametrs[:id])
  end
end
