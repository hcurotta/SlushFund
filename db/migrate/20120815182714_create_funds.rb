class CreateFunds < ActiveRecord::Migration
  def change
    create_table :funds do |t|
      t.integer :user_id
      t.string :name
      t.datetime :party_time
      t.float :budget
      t.text :description

      t.timestamps
    end
  end
end
