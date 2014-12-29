class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :competition
      t.references :level
      t.integer :number

      t.timestamps
    end

    add_foreign_key :events, :competitions, on_delete: :cascade
    add_foreign_key :events, :levels, on_delete: :restrict
  end
end
