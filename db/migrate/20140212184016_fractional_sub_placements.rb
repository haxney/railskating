class FractionalSubPlacements < ActiveRecord::Migration
  def up
    change_column :sub_placements, :rank, :decimal, precision: 5, scale: 2
  end

  def down
    change_column :sub_placements, :rank, :integer
  end
end
