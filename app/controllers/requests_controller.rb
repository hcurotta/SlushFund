class RequestsController < ApplicationController
  
def create
request = Request.create(params[:request]) 
   # 
   # if attendee.errors.any?
   #    redirect_to fund_url(params[:attendee][:fund_id]), :error => "Error" and return
   # end
 
redirect_to fund_url(params[:request][:fund_id])
 
end
  
  def destroy
    Attendee.find_by_id(params[:id]).destroy
    redirect_to fund_url (params[:fund_id])
  end
  
end