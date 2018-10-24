class ApplicationMailer < ActionMailer::Base
  user_email = Rails.application.config.action_mailer.smtp_settings[:user_name]
  default from: user_email
  layout "mailer"
end
