class CreateCouples < ActiveRecord::Migration
  def change
    create_table :couples do |t|
      t.integer :lead_id
      t.integer :follow_id
      t.integer :event_id
      t.integer :number

      t.timestamps
    end
  end
end
