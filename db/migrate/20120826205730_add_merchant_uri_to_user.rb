class AddMerchantUriToUser < ActiveRecord::Migration
  def change
    add_column :users, :merchant_uri, :string
  end
end
