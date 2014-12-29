class CreateSubPlacements < ActiveRecord::Migration
  def change
    create_table :sub_placements do |t|
      t.references :couple, index: true
      t.references :sub_event, index: true
      t.integer :rank

      t.timestamps
    end

    add_foreign_key :sub_placements, :couples, on_delete: :cascade
    add_foreign_key :sub_placements, :sub_events, on_delete: :cascade
  end
end
