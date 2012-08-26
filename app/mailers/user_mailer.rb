class UserMailer < ActionMailer::Base
  default :from => "slushfundmailer@gmail.com"
  
  def registration_confirmation(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to Slush Fund")
  end
 
 def send_mass_mail (attendee, fund)
   @root_url = root_url
   @attendee = attendee
   @fund = fund
   mail(:to => attendee.email, :subject => "#{@fund.user.name} wants you to chip in!")
  end 
  def send_reminder (attendee, fund, subject, body)
    @attendee = attendee
    @fund = fund
    @subject = subject
    @body = body
    mail(:to => attendee.email, :subject => @subject)
  end
  
end
