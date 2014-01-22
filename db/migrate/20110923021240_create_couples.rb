class CreateCouples < ActiveRecord::Migration
  def change
    create_table :couples do |t|
      t.references :lead, foreign_key: { on_delete: :restrict, references: :users }
      t.references :follow, foreign_key: { on_delete: :restrict, references: :users }
      t.references :event, foreign_key: { on_delete: :cascade }
      t.integer :number

      t.timestamps
    end
  end
end
