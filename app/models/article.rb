class Article < ApplicationRecord
    validates :title, presence: true, length: { minimum: 5 }
    # remove optional
    # belongs_to :user, optional: true
    belongs_to :user
    has_many :user_articles, dependent: :destroy
    has_many :favorite_articles, through: :user_articles, source: :user
    has_many :comments, as: :commentable 
end
