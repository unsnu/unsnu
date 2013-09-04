class Article < ActiveRecord::Base
	belongs_to :board
    belongs_to :user
	has_many :comments
    has_many :voted_users, foreign_key: 'article_id', class_name: 'ArticleVote'
end
