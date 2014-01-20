class AddIndexToMarks < ActiveRecord::Migration
  def change
    add_index :marks, [:couple_id, :sub_round_id]
  end
end
