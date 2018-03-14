class BraintreeController < ApplicationController
  def new
    @client_token = Braintree::ClientToken.generate
    @appointment = Appointment.find(params[:id]) 
  end

  def checkout
    @appointment = Appointment.find(params[:id]) 
    @user = current_user

    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

    result = Braintree::Transaction.sale(
     :amount => "200.00", #this is currently hardcoded
     :payment_method_nonce => nonce_from_the_client,
     :options => {
        :submit_for_settlement => true
      }
     )

    if result.success?
      @appointment.update(payment_status: "Paid")
      @appointment.update(payment_amount: @appointment.provider.price.to_s)
      AppointmentMailer.payment_email(@user, @appointment).deliver
      
      redirect_to :root, :flash => { :success => "Transaction successful!" }
    else
      redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
    end
  end

end 
