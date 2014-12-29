class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.references :team

      t.timestamps
    end

    add_foreign_key :competitions, :teams, on_delete: :restrict
  end
end
