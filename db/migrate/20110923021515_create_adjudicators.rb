class CreateAdjudicators < ActiveRecord::Migration
  def change
    create_table :adjudicators do |t|
      t.references :user
      t.references :competition
      t.string :shorthand

      t.timestamps
    end

    add_foreign_key :adjudicators, :users, on_delete: :restrict
    add_foreign_key :adjudicators, :competitions, on_delete: :cascade
  end
end
