class ApplicationController < ActionController::Base
	include Clearance::Controller

  protect_from_forgery with: :exception

  def patient_allowed?(action:, user:)
    if user.patient?
      action
    else
      return redirect_to URI(request.referrer).path
    end
  end

end
