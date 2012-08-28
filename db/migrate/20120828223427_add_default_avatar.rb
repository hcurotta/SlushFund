class AddDefaultAvatar < ActiveRecord::Migration

def change
  change_column :funds, :avatar, :string, :default => "slushfund_avatar.png"
end

end