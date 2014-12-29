class CreatePlacements < ActiveRecord::Migration
  def change
    create_table :placements do |t|
      t.references :couple, index: true
      t.references :event, index: true
      t.integer :rank
      t.integer :rule

      t.timestamps
    end

    add_foreign_key :placements, :couples, on_delete: :cascade
    add_foreign_key :placements, :events, on_delete: :cascade
  end
end
