class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :event_id
      t.integer :number
      t.boolean :final
      t.integer :requested
      t.integer :cutoff

      t.timestamps
    end
  end
end
