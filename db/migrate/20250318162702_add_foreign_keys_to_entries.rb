class AddForeignKeysToEntries < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :entries, :places
    add_foreign_key :entries, :users
  end
end