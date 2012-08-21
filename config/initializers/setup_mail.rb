ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "http://gmail.com",
  :user_name            => "slushfundmailer@gmail.com",
  :password             => "slushfund69",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

# TODO change mailer to sendgrid for more emails/day