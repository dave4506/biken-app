class AddStuffToRides < ActiveRecord::Migration
  def change
    add_column :rides, :title, :string
    add_column :rides, :content, :string
    add_reference :rides, :user, index: true
    add_column :rides, :start_at, :datetime
    add_column :rides, :end_at, :datetime
    add_column :rides, :meet_at, :string
  end
end
