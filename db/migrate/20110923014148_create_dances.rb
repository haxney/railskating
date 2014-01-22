class CreateDances < ActiveRecord::Migration
  def change
    create_table :dances do |t|
      t.string :name
      t.references :section, foreign_key: { on_delete: :restrict }

      t.timestamps
    end
  end
end
