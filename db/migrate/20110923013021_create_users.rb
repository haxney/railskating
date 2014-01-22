class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.references :team, foreign_key: { on_delete: :restrict }

      t.timestamps
    end
  end
end
