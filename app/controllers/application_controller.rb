class ApplicationController < ActionController::Base
	include Clearance::Controller

  protect_from_forgery with: :exception

  def patient_allowed?(action:, user:)
    if user.patient?
      action
    else
      return redirect_to URI(request.referrer).path, notice: "Sorry, as a Provider, you do not have access to this page."
    end
  end

end
