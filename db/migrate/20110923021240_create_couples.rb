class CreateCouples < ActiveRecord::Migration
  def change
    create_table :couples do |t|
      t.references :lead
      t.references :follow
      t.references :event
      t.integer :number

      t.timestamps
    end

    add_foreign_key :couples, :users, on_delete: :restrict, column: :lead
    add_foreign_key :couples, :users, on_delete: :restrict, column: :follow
    add_foreign_key :couples, :events, on_delete: :cascade
  end
end
