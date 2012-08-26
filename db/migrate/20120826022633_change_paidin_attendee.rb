class ChangePaidinAttendee < ActiveRecord::Migration
def change
  change_column :attendees, :paid, :boolean, :default => false
end
end
