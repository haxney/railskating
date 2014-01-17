class CreateSubPlacements < ActiveRecord::Migration
  def change
    create_table :sub_placements do |t|
      t.references :couple, index: true
      t.references :sub_event, index: true
      t.integer :rank

      t.timestamps
    end
  end
end
