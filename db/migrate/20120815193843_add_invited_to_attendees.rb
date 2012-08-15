class AddInvitedToAttendees < ActiveRecord::Migration
  def change
    add_column :attendees, :invited, :boolean, :default => false
  end
end
