class Article < ActiveRecord::Base
	belongs_to :board
  belongs_to :user
	has_many :comments
  has_many :voted_users, foreign_key: 'article_id', class_name: 'ArticleVote'

  def page_num(options = {})
    column = options[:by] || :id
    order = options[:order] || :asc
    per = options[:per] || self.class.default_per_page

    operator = (order == :asc ? "<=" : ">=")
    (self.class.where("#{column} #{operator} ? AND board_id = ?", read_attribute(column), self.board_id).order("#{column} #{order}").count.to_f / per).ceil
  end
end
