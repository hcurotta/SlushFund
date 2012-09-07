class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :item
      t.string :user_id

      t.timestamps
    end
  end
end
