class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :competition_id
      t.integer :level_id
      t.integer :number

      t.timestamps
    end
  end
end
