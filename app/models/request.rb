class Request < ActiveRecord::Base
  attr_accessible :item, :votes, :fund_id
  belongs_to :fund
  
  def vote_up
    self.votes = self.votes + 1
    self.save
  end
  
  def self.sms_requests(fund_id)
    @account_sid = 'ACbf14a19686b4ee7956b67a1f6bd3a1ea'
    @auth_token = ENV["twilio_key"]
    
    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)
    @requests = Request.all(:conditions => {:fund_id => fund_id}, :order => "votes DESC")

    shopping_list = ""

    # Append each item to the list... limit the total message body to 160 characters, leaving room for the footer link
    @requests.each do |request|
      shopping_list += "#{request.votes} #{request.item} 
"
      shopping_list = shopping_list.slice(0..122) if shopping_list.length > 126
      break if shopping_list.length>125
    end
    shopping_list +="...
full list www.slushfund.me/#{fund_id}/list"

    puts shopping_list
    puts shopping_list.length

    @account = @client.account
    # @message = @account.sms.messages.create({:from => '+13129489631', :to => '+13125135111', :body => shopping_list })
    puts @message
  end
  
end
