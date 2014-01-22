class CreateSubRounds < ActiveRecord::Migration
  def change
    create_table :sub_rounds do |t|
      t.references :round, foreign_key: { on_delete: :cascade }, index: true
      t.references :sub_event, foreign_key: { on_delete: :cascade }, index: true

      t.timestamps
    end
  end
end
