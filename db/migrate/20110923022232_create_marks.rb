class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.integer :adjudicator_id
      t.integer :round_id
      t.integer :couple_id
      t.integer :placement

      t.timestamps
    end
  end
end
