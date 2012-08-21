class AttendeesController < ApplicationController
  
def create
attendee = Attendee.create(params[:attendee]) 
   # 
   # if attendee.errors.any?
   #    redirect_to fund_url(params[:attendee][:fund_id]), :error => "Error" and return
   # end
 
redirect_to fund_url(params[:attendee][:fund_id])
 
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