
class PatientsController < UsersController

  before_action :patient_allowed?

  def index
    @patients = Patient.all
  end

  def edit
    @patient = Patient.find(params[:id])
    
  end

  def show
    # patient_allowed?(user: current_user, action: @patient)
    @patient = Patient.find(params[:id])
  end

  private

  def user_params
      params.require(:patient).permit(:email, :username, :profile_picture, :password, :first_name, :default_picture, :last_name, :gender, :phone_number, :birthday, {image:[]}, {medical_history:[]}, :remember_token, :price, :location, :name, :treatment, :language, {profile_picture_json:[]}, {qualification:[]})
  end

  def patient_allowed?
    unless current_user.patient?
      flash[:danger] = "Sorry, as a Provider, you do not have access to this page."
      redirect_back fallback_location: root_path
      # return redirect_back fallback_location: root_path, notice: "Sorry, as a Provider, you do not have access to this page."
    end
  end
end