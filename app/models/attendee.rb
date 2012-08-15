class Attendee < ActiveRecord::Base
  attr_accessible :email, :fund_id, :name, :paid, :invited
  
  validates_presence_of :email, :name
  
  validates :email, :format => {:with => /@/}
  
  belongs_to :fund
end
