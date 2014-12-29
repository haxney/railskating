class CreateSubEvents < ActiveRecord::Migration
  def change
    create_table :sub_events do |t|
      t.references :event
      t.references :dance
      t.integer :weight

      t.timestamps
    end

    add_foreign_key :sub_events, :events, on_delete: :cascade
    add_foreign_key :sub_events, :dances, on_delete: :restrict
  end
end
