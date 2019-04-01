class Api::V1::UsersController < ApplicationController
	def index
		@users = User.all

		render json: @users, status: :success
	end

	def show
		@user = User.find(params[:id])
		@comments = @user.comments
		
		render json: @user, status: :success
	end

	def get_articles
		@user = current_user
		@articles = @user.articles

		render json: @articles, status: :success
	end
end
