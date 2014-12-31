class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :competition, foreign_key: { on_delete: :cascade }
      t.references :level, foreign_key: { on_delete: :restrict }
      t.integer :number

      t.timestamps
    end
  end
end
