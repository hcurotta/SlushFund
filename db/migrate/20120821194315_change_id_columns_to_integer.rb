class ChangeIdColumnsToInteger < ActiveRecord::Migration
  def self.up
     change_column :requests, :user_id, :integer
     
    end

    def self.down
      change_column :requests, :user_id, :string
    end
end
