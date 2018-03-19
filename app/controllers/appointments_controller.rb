class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = Appointment.all
  end

  # GET /appointments/1
  # GET /appointments/1.json


  # GET /appointments/new
  def new
    @appointment = Appointment.new
    @provider = Provider.find(params[:provider_id])

  end


  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @provider = Provider.find(params[:provider_id])  
    @appointment = @provider.appointments.new(appointment_params)
    @appointment.patient_id = current_user.id
    # respond_to do |format|
      if @appointment.save
        @providers = @appointment.provider
        AppointmentMailer.appointment_email(current_user, @provider, @appointment).deliver
        redirect_to braintree_new_path(@appointment), :flash => { :success => "Appointment was successfully created." }
        # redirect_to braintree_new_path(@appointment), success: 'Appointment was successfully created'
        # redirect_to provider_appointment_path(@providers, @appointment), notice: 'Appointment was successfully created'
      else
        redirect_to root_path
    end
  end
 
  def show
    @provider = Provider.find(params[:provider_id])
    set_appointment
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: 'Appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:patient_id, :provider_id, :date, :start_time, :end_time, :id)
    end
end
