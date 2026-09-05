class UserMailer < ApplicationMailer
  def auto_create_welcome user, password
    @user = user
    @password = password
    mail to: @user.email, subject: 'Welcome to Kaapad!'
  end
end
