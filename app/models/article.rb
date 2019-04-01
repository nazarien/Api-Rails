class Article < ApplicationRecord
    validates :title, presence: true, length: { minimum: 5 }
    
    belongs_to :user, optional: true
    has_many :user_articles, dependent: :destroy
    has_many :favorite_articles, through: :user_articles, source: :user
    has_many :comments, as: :commentable 
end
