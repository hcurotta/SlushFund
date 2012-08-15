class UserMailer < ActionMailer::Base
  default :from => "slushfundmailer@gmail.com"
  
  def registration_confirmation(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to Slush Fund")
  end
  
end
