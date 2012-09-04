class AddUnpaidToUser < ActiveRecord::Migration
  def change
    add_column :users, :amount_in_escrow, :float, :default => 0
  end
end
