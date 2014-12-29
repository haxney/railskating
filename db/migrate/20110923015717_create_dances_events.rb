class CreateDancesEvents < ActiveRecord::Migration
  def change
    create_join_table :dances, :events
  end
end
