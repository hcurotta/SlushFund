class AddLocationToFund < ActiveRecord::Migration
  def change
    add_column :funds, :location, :string
  end
end
