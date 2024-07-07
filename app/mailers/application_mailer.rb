class ApplicationMailer < ActionMailer::Base
  default from: "user@realdomain.com"   #from@example.com
  layout "mailer"
end
