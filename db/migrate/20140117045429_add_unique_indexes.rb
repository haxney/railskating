class AddUniqueIndexes < ActiveRecord::Migration
  def change
    add_index :couples_rounds, [:couple_id, :round_id], unique: true
  end
end
