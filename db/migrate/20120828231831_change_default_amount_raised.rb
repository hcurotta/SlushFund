class ChangeDefaultAmountRaised < ActiveRecord::Migration
  def change
    change_column :funds, :amount_raised, :float, :default => 0
  end
end
