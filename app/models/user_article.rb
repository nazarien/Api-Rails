class UserArticle < ApplicationRecord
    validates_uniqueness_of :article_id, :scope => :user_id
    
    belongs_to :user
    belongs_to :article
end
