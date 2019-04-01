class Comment < ApplicationRecord
  validates :commenter, :body, presence: true
  
  belongs_to :commentable, polymorphic: true
end
