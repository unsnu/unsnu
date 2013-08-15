class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :nickname
      t.text :content
      t.integer :upvote
      t.integer :downvote
      t.integer :comment_count
      t.boolean :locked?
      t.integer :view_count

      t.timestamps
    end
  end
end
