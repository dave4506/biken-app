class AddUserKey < ActiveRecord::Migration
  def change
    add_foreign_key :rides, :users
    add_index :rides, [:user_id, :created_at]
  end
end
