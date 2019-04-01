class Api::V1::UserArticlesController < ApplicationController
  def index
    @saved_aritcles = current_user.favorite_articles

    render json: @saved_aritcles, status: :success
  end

  def create
    @favorite_article = current_user.user_articles.new(article_id: find_article.id)
    if @favorite_article.save
      render json: @favorite_article, status: :success
    else
			render json: @favorite_article.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.favorite_articles.delete(find_article)
			head(:success)
		else
			render json: @article.errors, status: :unprocessable_entity
		end
  end

  private

  def parametrs
    params.permit(:id)
  end

  def find_article
    @article ||= Article.find(parametrs[:id])
  end
end
