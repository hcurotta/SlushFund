class RemoveDefaultfromAvatar < ActiveRecord::Migration
  def change
    change_column :funds, :avatar, :string
  end
end
