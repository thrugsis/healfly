class UserMailer < ApplicationMailer

	def user_email(user)
    @user = user
    @url = "https://healfly.herokuapp.com/"
    mail(to: @user.email, subject: 'Welcome to HealFly')
  	end

end