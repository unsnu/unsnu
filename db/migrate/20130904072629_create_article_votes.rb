class CreateArticleVotes < ActiveRecord::Migration
  def change
    create_table :article_votes, id: false do |t|
      t.integer :article_id
      t.integer :user_id

      t.timestamps
    end
  end
end
