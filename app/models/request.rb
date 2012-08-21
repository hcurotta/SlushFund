class Request < ActiveRecord::Base
  attr_accessible :item, :votes, :fund_id
  belongs_to :fund
end
