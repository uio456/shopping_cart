class Mailer < ApplicationMailer
  def say_hi(user)
    @user = user
    mail to:"loxa10077@gmail.com", subject:"你好!!"
  end
end
