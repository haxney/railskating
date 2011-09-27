class RemoveDancesEvents < ActiveRecord::Migration
  def up
    drop_table :dances_events
  end

  def down
    create_table :dances_events, :id => false do |t|
      t.references :dance, :event
    end
  end
end
