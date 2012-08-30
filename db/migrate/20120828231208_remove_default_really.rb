class RemoveDefaultReally < ActiveRecord::Migration
def change
  change_column :funds, :avatar, :string, :default => nil
end
end
