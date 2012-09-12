ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "http://gmail.com",
  :user_name            => ENV["mailer_email"],
  :password             => ENV["mailer_email_password"],
  :authentication       => "plain",
  :enable_starttls_auto => true
}

# TODO change mailer to sendgrid for more emails/day