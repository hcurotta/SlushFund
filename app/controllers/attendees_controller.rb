class AttendeesController < ApplicationController
  
before_filter :require_session , :only => [:invite , :create, :sendmail, :sendreminder, :destroy]
before_filter :require_match , :only => [:invite, :sendreminder, :destroy]

def require_session   #must be logged in.  These don't require a match because actions are based off their session[:user_id]
  if !session[:user_id]
    redirect_to root_url, :notice => "You must be logged in to see that!"
  end
end
def require_match   #edit page can be accessed via URL so make sure the fund they try to access is one of theirs
  if params[:fund_id]
    fund_id = params[:fund_id]
  elsif params[:id]
    fund_id = params[:id]
  end
  if !User.find(session[:user_id]).funds.include?(Fund.find(fund_id))
    redirect_to root_url , :notice => "You don't have permission to do that!"
  end
end  
  
   
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
  
  @attendees.each do |attendee|       #TODO is less robust? Sending 30 emails vs 1 email with 30 recipients
    UserMailer.send_mass_mail(attendee, @fund).deliver
    attendee.invited = true
    attendee.save
  end
    redirect_to fund_url(@fund.id) , :notice => "You successfully emailed that attendee list!"
    return
end

def sendreminder
  @fund = Fund.find_by_id(params[:fund_id])
  if params[:recipients] == "everyone"
    @attendees = @fund.attendees
  else
     @attendees = @fund.attendees.where("paid = ?", FALSE)
  end
  
  @subject = params[:subject]
  @body = params[:body]
  
  @attendees.each do |attendee|   #TODO is less robust? Sending 30 emails vs 1 email with 30 recipients
     UserMailer.send_reminder(attendee, @fund, @subject, @body ).deliver
   end
     redirect_to fund_url(@fund.id) , :notice => "You successfully sent out a reminder!"
     return
end
  
def destroy
  @attendee = Attendee.find_by_id(params[:id])
  @attendee.destroy
  
  respond_to do |format|
     format.js
     format.html { redirect_to fund_url(params[:fund_id])} # index.html.erb
   end
   
end
  
end