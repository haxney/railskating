class CreateSubEvents < ActiveRecord::Migration
  def change
    create_table :sub_events do |t|
      t.references :event
      t.references :dance
      t.integer :order

      t.timestamps
    end
  end
end
