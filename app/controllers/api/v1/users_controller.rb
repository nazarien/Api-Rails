class Api::V1::UsersController < ApplicationController
	before_action :authenticate_user!, except: [:index]

	def index
		@users = User.all

		render json: @users, status: 200
	end

	def show
		@user = User.find(params[:id])
		@comments = @user.comments

		render json: @user, status: 200
	end

	def get_articles
		@user = current_user
		@articles = @user.articles

		render json: @articles, status: 200
	end
end
