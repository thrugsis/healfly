class ApplicationController < ActionController::Base
	include Clearance::Controller

  protect_from_forgery with: :exception

  def patient_allowed?(user:, action:)

    if user.patient?
      action
    else
      return redirect_back fallback_location: root_path, notice: "Sorry, as a Provider, you do not have access to this page."
    end
  end

  def provider_allowed?(user:, action:)
    if user.provider?
      action
    else
      return redirect_back fallback_location: root_path, notice: "Sorry, as a Patient, you do not have access to this page."
    end
  end

  def public_allowed?(user:, action:)
    if user.provider? || user.patient?
      return redirect_back fallback_location: root_path, notice: "Sorry, this page is not opened to the general public."
    else
      action
    end
  end 

end


# URI(request.referrer).path