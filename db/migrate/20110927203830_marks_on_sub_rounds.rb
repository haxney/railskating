class MarksOnSubRounds < ActiveRecord::Migration
  def change
    change_table :marks do |t|
      t.rename :round_id, :sub_round_id
    end
  end
end
