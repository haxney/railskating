class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :name
      t.integer :weight

      t.timestamps
    end
  end
end
