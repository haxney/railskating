class CreateAdjudicators < ActiveRecord::Migration
  def change
    create_table :adjudicators do |t|
      t.references :user, foreign_key: { on_delete: :restrict }
      t.references :competition, foreign_key: { on_delete: :cascade }
      t.string :shorthand

      t.timestamps
    end
  end
end
