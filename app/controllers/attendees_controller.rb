class AttendeesController < ApplicationController
  
  
def invite
  @fund = Fund.find_by_id(params[:id])
  @attendee = Attendee.new
  @errormessages = @attendee.errors.full_messages
end
    
def create
  @attendee = Attendee.create(params[:attendee]) 
  
  respond_to do |format|
    format.js
    format.html # index.html.erb
  end
     # 
     # if attendee.errors.any?
     #    redirect_to fund_url(params[:attendee][:fund_id]), :error => "Error" and return
     # end
 
  # redirect_to fund_url(params[:attendee][:fund_id])
end

def sendmail
  @fund = Fund.find_by_id(params[:fund_id])
  @attendees = @fund.attendees.where("invited = ?", FALSE)
  
  @attendees.each do |attendee|
  UserMailer.send_mass_mail(attendee, @fund).deliver
  # attendee.invited = true
  end
    redirect_to fund_url(@fund.id) , :notice => "You successfully emailed that attendee list!"
    return
end
  
  def destroy
    Attendee.find_by_id(params[:id]).destroy
    redirect_to fund_url (params[:fund_id])
  end
  
end