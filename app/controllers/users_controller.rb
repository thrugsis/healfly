class UsersController < Clearance::UsersController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    
  end

  # POST /users
  # POST /users.json
  def create
    if params[:user][:type] == "patient"
      @user = Patient.new(user_params)
    else
      @user = Provider.new(user_params)
    end
   
    respond_to do |format|
      if @user.save
        sign_in(@user)
        if @user.patient?
          format.html { redirect_to edit_patient_path(@user) }
        else
          format.html { redirect_to edit_provider_path(@user) } 
        end
      else
        format.js 
      end 
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def verification
    @user_id = User.find(params[:id])
  end

  def verification_submit
      @user = User.find(current_user)
      @user.update(type: "Provider") 
      redirect_to root_url
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :username, :password, :first_name, :last_name, :gender, :phone_number, :birthday, :image, :medical_history, :remember_token, :price, :location, :name, :treatment, :language, :image, :qualification)
    end

end
