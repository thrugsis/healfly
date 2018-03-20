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
    set_provider
    @appoint = @provider.appointments.all
  end

  # GET /providers/new
  def new
    @provider = Provider.new
  end

  # GET /providers/1/edit
  def edit
    @provider = Provider.find(params[:id])
  end

  # POST /providers
  # POST /providers.json
  def create
    @provider = Provider.new(provider_params)
      if @provider.save
        redirect_to @provider, :flash => { :success => 'Provider was successfully created.' }
      else
        redirect_to root_url, :flash => { :danger => "Could not create Provider profile."}
      end
  end

  # PATCH/PUT /providers/1
  # PATCH/PUT /providers/1.json
  def update
    @provider = Provider.find(params[:id])
    @provider = @provider.update(provider_params)

    if @provider
      redirect_to root_url, :flash => { :success => 'Provider was successfully updated.' } 
    else
      redirect_to provider_path(@provider), :flash => { :danger => "Could not update Provider profile." }
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
    # byebug
    end
    # @search_keyword = value

    respond_to do |format|
     format.js
     format.html { render :index }                    
    end
  
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_provider
      @provider = Provider.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def provider_params
      params.require(:provider).permit(:name, :location, :treatment, :profile_picture, :language, :gender, :price, {image:[]}, {qualification:[]})

    end

    def search_params(params)
      params.slice(:treatment, :location, :language, :min_price, :max_price)
    end 

end
