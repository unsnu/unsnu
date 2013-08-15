class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :snuid_digest
      t.date :anonymous_available_date
      t.string :anonymous_nickname
      t.string :nickname

      t.timestamps
    end
  end
end
