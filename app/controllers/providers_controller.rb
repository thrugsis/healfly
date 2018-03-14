class ProvidersController < UsersController
  before_action :set_provider, only: [:show, :edit, :update, :destroy]

  # GET /providers
  # GET /providers.json
  def index
    @providers = Provider.all
  end

  # GET /providers/1
  # GET /providers/1.json
  def show

    #IF CURRENT USER NOT LOGGED IN, WILL STOP
    # allowed?(action: @provider, user: current_user)
    @provider = Provider.find(params[:id])
  end

  # GET /providers/new
  def new
    @provider = Provider.new
  end

  # GET /providers/1/edit
  def edit
  end

  # POST /providers
  # POST /providers.json
  def create
    @provider = Provider.new(provider_params)

    respond_to do |format|
      if @provider.save
        format.html { redirect_to @provider, notice: 'Provider was successfully created.' }
        format.json { render :show, status: :created, location: @provider }
      else
        format.html { render :new }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /providers/1
  # PATCH/PUT /providers/1.json
  def update
    respond_to do |format|
      if @provider.update(provider_params)
        format.html { redirect_to @provider, notice: 'Provider was successfully updated.' }
        format.json { render :show, status: :ok, location: @provider }
      else
        format.html { render :edit }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /providers/1
  # DELETE /providers/1.json
  def destroy
    @provider.destroy
    respond_to do |format|
      format.html { redirect_to providers_url, notice: 'Provider was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def search
    @providers = Provider.all 

    search_params(params).each do |key, value|
      @providers = @providers.public_send(key, value) if value.present?
    end

    @params = params

    respond_to do |format|
     format.js
     format.html { render :index }                    # This will work. This is because render will carry all the logic of the method render is written.
     # format.html { redirect_to providers_path }     # This won't work.
    end
  
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_provider
      @provider = Provider.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def provider_params
      params.require(:provider).permit(:name, :location, :treatment, :language, :price, {image:[]}, {qualification:[]})
    end

    def search_params(params)
      params.slice(:treatment, :location, :language, :min_price, :max_price)
    end 

end
