class Request < ActiveRecord::Base
  attr_accessible :item, :votes, :fund_id
  belongs_to :fund
  
  def vote_up
    self.votes = self.votes + 1
    self.save
  end
end
