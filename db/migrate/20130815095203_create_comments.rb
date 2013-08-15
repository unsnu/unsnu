class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :nickname
      t.string :content
      t.boolean :has_children?
      t.references :parent, index: true
      t.integer :cascade_level

      t.timestamps
    end
  end
end
