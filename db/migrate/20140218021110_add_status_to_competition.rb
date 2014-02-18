class AddStatusToCompetition < ActiveRecord::Migration
  def change
    add_column :competitions, :status, :string
  end
end
