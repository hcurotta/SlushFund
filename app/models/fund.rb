class Fund < ActiveRecord::Base
  attr_accessible :budget, :description, :name, :party_time, :user_id, :avatar, :amount_raised, :deadline, :host, :location
  
  belongs_to :user
  has_many :attendees
  has_many :requests
  
  validates_presence_of :deadline, :budget, :name, :party_time, :host, :location, :description
  validate :time_after_today
  validates :budget, :numericality => true
  
  def time_after_today
    if party_time < DateTime.now || deadline < DateTime.now
      errors.add(:party_time, "must be after today")
      errors.add(:deadline, "must be after today")
    end
  end

  
  mount_uploader :avatar , AvatarUploader
end
