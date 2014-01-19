class AddAdjudicatorsToRounds < ActiveRecord::Migration
  def change
    create_join_table :adjudicators, :rounds do |t|
      t.index [:adjudicator_id, :round_id], unique: true
    end
  end
end
