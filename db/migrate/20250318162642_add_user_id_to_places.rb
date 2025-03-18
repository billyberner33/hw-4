class AddUserIdToPlaces < ActiveRecord::Migration[7.1]
  def change
    add_column :places, :user_id, :integer
    add_foreign_key :places, :users
  end
end