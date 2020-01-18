class Mailer < ApplicationMailer
  #除非對方授權，不然免錢的 mailgun 不能隨便寄到別人的電子信箱
  def say_hi(user)
    @user = user
    mail to: @user.email, subject:"你好!!"
  end

  def send_file(to, subject, body, files:{})
    files.each do |name, file|
      attachments[name] = file.read
    end

    mail to: to, subject: subject, body: body
  end

end
