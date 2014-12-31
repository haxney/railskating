class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.references :team, foreign_key: { on_delete: :restrict }

      t.timestamps
    end
  end
end
