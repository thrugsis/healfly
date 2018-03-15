class PatientsController < UsersController

  def index
    public_allowed?(user: current_user, action: @patients)
    @patients = Patient.all
  end

  def edit
    @patient = Patient.find(params[:id])
    
  end

  def show
    patient_allowed?(user: current_user, action: @patient)
    @patient = Patient.find(params[:id])
  end

  private

  def user_params
      params.require(:patient).permit(:email, :username, :password, :first_name, :last_name, :gender, :phone_number, :birthday, {image:[]}, {medical_history:[]}, :remember_token, :price, :location, :name, :treatment, :language, {image:[]}, {qualification:[]})
  end
end

# params.fetch(:patient, {})