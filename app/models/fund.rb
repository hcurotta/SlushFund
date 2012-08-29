class Fund < ActiveRecord::Base
  attr_accessible :budget, :description, :name, :party_time, :user_id, :avatar, :amount_raised, :deadline
  
  belongs_to :user
  has_many :attendees
  has_many :requests
  
  mount_uploader :avatar , AvatarUploader
end
