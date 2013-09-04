class VotedArticlesVotedUsers < ActiveRecord::Migration
  def change
    create_table :voted_articles_voted_users, id: false do |t|
      t.integer :voted_article_id
      t.integer :voted_user_id
    end
  end
end
