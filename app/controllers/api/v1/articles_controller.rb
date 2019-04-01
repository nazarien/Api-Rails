class Api::V1::ArticlesController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@articles = Article.all
		
		render json: @articles, status: :success
	end

  def show
		@article = Article.find(params[:id])
		@comments = @article.comments

		render json: @article, status: :success
	end
	
	def create
		@article = current_user.articles.new(article_params)
		if @article.save
			render json: @article, status: :created
		else
			render json: @article.errors, status: :unprocessable_entity
		end
	end

	def destroy
		if set_article.destroy
			head(:success)
		else
			render json: @article.errors, status: :unprocessable_entity
		end
  end
	
	private

  def article_params
    params.require(:article).permit(:title, :text)
  end

  def set_article
    @article ||= current_user.articles.find(params[:id])
  end
end
