class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.references :event
      t.integer :number
      t.boolean :final
      t.integer :requested
      t.integer :cutoff

      t.timestamps
    end

    add_foreign_key :rounds, :events, on_delete: :cascade
  end
end
