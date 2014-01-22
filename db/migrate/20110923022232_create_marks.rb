class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.references :adjudicator, foreign_key: { on_delete: :cascade }
      t.references :sub_round, foreign_key: { on_delete: :cascade }
      t.references :couple, foreign_key: { on_delete: :cascade }
      t.integer :placement

      t.timestamps
    end
  end
end
