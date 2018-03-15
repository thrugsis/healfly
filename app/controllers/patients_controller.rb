class PatientsController < UsersController

  def index
    @patients = Patient.all
  end

  def edit
    @patient = Patient.find(params[:id])
    
  end

  def show
    patient_allowed?(action: @patient, user: current_user)
    @patient = Patient.find(params[:id])
  end

  private

  def user_params
      params.require(:patient).permit(:email, :username, :password, :first_name, :last_name, :gender, :phone_number, :birthday, {image:[]}, {medical_history:[]}, :remember_token, :price, :location, :name, :treatment, :language, {image:[]}, {qualification:[]})
  end
end

# params.fetch(:patient, {})