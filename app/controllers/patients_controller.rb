class PatientsController < UsersController

  def index

  end

  def edit
    
  end

  def show

  end

  private

  def user_params
      params.require(:patient).permit(:email, :username, :password, :first_name, :last_name, :gender, :phone_number, :birthday, :image, :medical_history, :remember_token, :price, :location, :name, :treatment, :language, :image, :qualification)
  end
end

# params.fetch(:patient, {})