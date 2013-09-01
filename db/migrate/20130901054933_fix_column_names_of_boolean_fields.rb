class FixColumnNamesOfBooleanFields < ActiveRecord::Migration
  def change
    rename_column :articles, :locked?, :locked
    rename_column :boards, :anonymous?, :anonymous
    rename_column :comments, :has_children?, :has_children
  end
end
