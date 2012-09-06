class Fund < ActiveRecord::Base
  attr_accessible :budget, :description, :name, :party_time, :user_id, :avatar, :amount_raised, :deadline, :host, :location
  
  belongs_to :user
  has_many :attendees
  has_many :requests
  
  validates_presence_of :deadline, :budget, :name, :party_time, :host, :location, :description
  
  mount_uploader :avatar , AvatarUploader
end
