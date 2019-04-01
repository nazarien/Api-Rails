# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  has_many :articles
  has_many :user_articles, dependent: :destroy
  has_many :favorite_articles, through: :user_articles, source: :article
  has_many :comments, as: :commentable

  enum role: [:user, :author]
end
