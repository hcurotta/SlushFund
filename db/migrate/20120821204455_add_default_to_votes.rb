class AddDefaultToVotes < ActiveRecord::Migration
  def change
    change_column :requests, :votes, :integer, :default => 0
  end
end
