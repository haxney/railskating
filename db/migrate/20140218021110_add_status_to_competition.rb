class AddStatusToCompetition < ActiveRecord::Migration
  def change
    add_column :competitions, :status, :integer, default: 0
  end
end
