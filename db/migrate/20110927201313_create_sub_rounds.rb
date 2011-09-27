class CreateSubRounds < ActiveRecord::Migration
  def change
    create_table :sub_rounds do |t|
      t.references :round
      t.references :sub_event

      t.timestamps
    end
    add_index :sub_rounds, :round_id
    add_index :sub_rounds, :sub_event_id
  end
end
