class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.references :team

      t.timestamps
    end

    add_foreign_key :users, :teams, on_delete: :restrict
  end
end
