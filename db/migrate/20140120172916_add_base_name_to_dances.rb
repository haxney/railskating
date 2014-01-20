class AddBaseNameToDances < ActiveRecord::Migration
  def change
    add_column :dances, :base_name, :string
  end
end
