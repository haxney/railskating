class CreateDances < ActiveRecord::Migration
  def change
    create_table :dances do |t|
      t.string :name
      t.references :section, foreign_key: { on_delete: :restrict }

      t.timestamps
    end

    add_foreign_key :dances, :sections, on_delete: :restrict
  end
end
