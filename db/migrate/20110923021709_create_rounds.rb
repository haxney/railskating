class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.references :event, foreign_key: { on_delete: :cascade }
      t.integer :number
      t.boolean :final
      t.integer :requested
      t.integer :cutoff

      t.timestamps
    end
  end
end
