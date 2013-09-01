class AddDefaultValueToArticleModel < ActiveRecord::Migration
  def change
    change_column :articles, :title, :string, null: false
    change_column :articles, :nickname, :string, null: false
    change_column :articles, :content, :text, null: false
    change_column :articles, :upvote, :integer, default: 0
    change_column :articles, :downvote, :integer, default: 0
    change_column :articles, :comment_count, :integer, default: 0
    change_column :articles, :locked, :boolean, default: false
    change_column :articles, :view_count, :integer, default: 0
    change_column :articles, :board_id, :integer, null: false
    change_column :articles, :user_id, :integer, null: false
  end
end
