class Api::V1::ArticlesController < ApplicationController
	before_action :authenticate_user!, except: [:index]

	def index
		@articles = Article.all
		authorize @articles
		
		render json: @articles, status: 200
	end

  def show
		@article = Article.find(params[:id])
		@comments = @article.comments
		authorize @article

		render json: @article, status: 200
	end
	
	def create
		@article = current_user.articles.new(article_params)
		authorize @article

		if @article.save
			render json: @article, status: :created
		else
			render json: @article.errors, status: 422
		end
	end

	def destroy
		authorize set_article
		set_article.destroy
	end

	def update
    authorize set_article
		set_article.update(article_params)
	end
	
	private

  def article_params
    params.require(:article).permit(:title, :text)
  end

  def set_article
    @article ||= current_user.articles.find(params[:id])
  end
end
