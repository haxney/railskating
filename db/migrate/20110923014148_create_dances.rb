class CreateDances < ActiveRecord::Migration
  def change
    create_table :dances do |t|
      t.string :name
      t.integer :section_id

      t.timestamps
    end
  end
end
