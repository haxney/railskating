class CreateSubEvents < ActiveRecord::Migration
  def change
    create_table :sub_events do |t|
      t.references :event, foreign_key: { on_delete: :cascade }
      t.references :dance, foreign_key: { on_delete: :restrict }
      t.integer :weight

      t.timestamps
    end
  end
end
