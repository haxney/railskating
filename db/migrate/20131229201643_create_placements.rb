class CreatePlacements < ActiveRecord::Migration
  def change
    create_table :placements do |t|
      t.references :couple, foreign_key: { on_delete: :cascade }, index: true
      t.references :event, foreign_key: { on_delete: :cascade }, index: true
      t.integer :rank
      t.integer :rule

      t.timestamps
    end
  end
end
