class ApplicationController < ActionController::Base
	include Clearance::Controller

  protect_from_forgery with: :exception

  def patient_allowed?(action:, user:)
    if user.patient?
      action
    else
      return redirect_to , notice: "Sorry, as a Provider, you do not have access to this page."
    end
  end

  def allowed?(action:, user:)
    if user.patient? || user.provider?
      action
    else
      flash[:notice] = "Sorry. You are not allowed to perform this action."
        return redirect_to "/", notice: "Sorry. You do not have the permission to verify a property."
    end
  end
end
