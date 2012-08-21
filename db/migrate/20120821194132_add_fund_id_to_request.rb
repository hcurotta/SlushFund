class AddFundIdToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :fund_id, :integer
  end
end
