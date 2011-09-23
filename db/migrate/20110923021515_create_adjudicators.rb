class CreateAdjudicators < ActiveRecord::Migration
  def change
    create_table :adjudicators do |t|
      t.integer :user_id
      t.integer :competition_id
      t.string :shorthand

      t.timestamps
    end
  end
end
