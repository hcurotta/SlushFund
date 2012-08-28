class AddAvatarandAmountRaisedToFund < ActiveRecord::Migration
  def change
    add_column :funds, :avatar, :string
    add_column :funds, :amount_raised, :float
    add_column :funds, :deadline, :date
  end
end
