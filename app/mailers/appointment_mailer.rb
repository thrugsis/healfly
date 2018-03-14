class AppointmentMailer < ApplicationMailer

	def appointment_email(user, provider, appointment)
    @user = user
    @url = "https://healfly.herokuapp.com/"
    @provider = provider
    @appointment = appointment
    mail(to: @user.email, subject: 'Your appointment has been created, thank you')
  end

  def payment_email(user)
    @user = user
    @url = "https://healfly.herokuapp.com/"
    mail(to: @user.email, subject: 'Thank you for your payment')
  end

end