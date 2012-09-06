class AddHosttoFund < ActiveRecord::Migration
  def change
    add_column :funds, :host, :string
  end
end
