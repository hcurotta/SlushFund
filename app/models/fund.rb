class Fund < ActiveRecord::Base
  attr_accessible :budget, :description, :name, :party_time, :user_id
  
  belongs_to :user
  has_many :attendees
  has_many :requests
end
