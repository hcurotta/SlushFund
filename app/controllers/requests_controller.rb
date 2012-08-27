class RequestsController < ApplicationController
  
def create
@request = Request.create(params[:request])
@fund = Fund.find_by_id(@request.fund_id)
   # 
   # if attendee.errors.any?
   #    redirect_to fund_url(params[:attendee][:fund_id]), :error => "Error" and return
   # end
   respond_to do |format|
     format.js
     format.html { redirect_to fund_url(params[:request][:fund_id])}
   end
 
end
  
  def destroy
    @request = Request.find_by_id(params[:id])
    @request.destroy
   
    respond_to do |format|
       format.js
       format.html { redirect_to fund_url (params[:fund_id])}
     end
  end
  
  def vote_up
    @request = Request.find_by_id(params[:id])
    @request.vote_up
    respond_to do |format|
      format.js
      format.html {redirect_to fund_url (params[:fund_id])}
    end
  end
end