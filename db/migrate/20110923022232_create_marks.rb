class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.references :adjudicator
      t.references :sub_round
      t.references :couple
      t.integer :placement

      t.timestamps
    end

    add_foreign_key :marks, :adjudicators, on_delete: :restrict
    add_foreign_key :marks, :sub_rounds, on_delete: :cascade
    add_foreign_key :marks, :couples, on_delete: :restrict
  end
end
