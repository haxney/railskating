class CreateSubRounds < ActiveRecord::Migration
  def change
    create_table :sub_rounds do |t|
      t.references :round, index: true
      t.references :sub_event, index: true

      t.timestamps
    end

    add_foreign_key :sub_rounds, :rounds, on_delete: :cascade
    add_foreign_key :sub_rounds, :sub_events, on_delete: :cascade
  end
end
