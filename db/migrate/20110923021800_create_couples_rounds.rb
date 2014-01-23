class CreateCouplesRounds < ActiveRecord::Migration
    def change
      create_join_table :couples, :rounds
  end
end
