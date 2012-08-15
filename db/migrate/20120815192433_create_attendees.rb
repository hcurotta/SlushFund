class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.string :email
      t.string :name
      t.integer :fund_id
      t.boolean :paid

      t.timestamps
    end
  end
end
