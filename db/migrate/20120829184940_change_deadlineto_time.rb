class ChangeDeadlinetoTime < ActiveRecord::Migration
  def change
    change_column :funds, :deadline, :datetime
  end
end
