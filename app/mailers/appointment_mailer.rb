class AppointmentMailer < ApplicationMailer

	def appointment_email(user, provider, appointment)
    @user = user
    @url = "https://healfly.herokuapp.com/"
    @provider = provider
    @appointment = appointment
    mail(to: @user.email, subject: 'Your appointment has been created, thank you')
  	end

end