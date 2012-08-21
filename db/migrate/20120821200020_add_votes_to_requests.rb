class AddVotesToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :votes, :integer
  end
end
