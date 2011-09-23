class CreateDancesEvents < ActiveRecord::Migration
  def change
    create_table :dances_events, :id => false do |t|
      t.references :dance, :event
    end
  end
end
