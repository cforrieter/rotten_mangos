class UserMailer < ApplicationMailer

  def delete_email(user)
    @user = user
    @url  = 'http://rottenmangos.com'
    mail(to: @user.email, subject: 'Your account has been deleted')
  end
end
