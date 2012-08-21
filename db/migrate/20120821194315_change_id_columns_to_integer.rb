class ChangeIdColumnsToInteger < ActiveRecord::Migration
  def self.up
     change_column :votes, :user_id, :integer
     change_column :votes, :item_id, :integer
     change_column :requests, :user_id, :integer
     
    end

    def self.down
      change_column :votes, :user_id, :string
      change_column :requests, :user_id, :string
      change_column :votes, :item_id, :string
    end
end
