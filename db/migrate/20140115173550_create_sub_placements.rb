class CreateSubPlacements < ActiveRecord::Migration
  def change
    create_table :sub_placements do |t|
      t.references :couple, foreign_key: { on_delete: :cascade }, index: true
      t.references :sub_event, foreign_key: { on_delete: :cascade }, index: true
      t.integer :rank

      t.timestamps
    end
  end
end
