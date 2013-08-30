class CreateCouplesRounds < ActiveRecord::Migration
    def change
    create_table :couples_rounds, :id => false do |t|
      t.references :couple, :round
    end
  end
end
