class InterventionsController < ApplicationController
  before_action :set_intervention, only: %i[ show edit update destroy ]

  # GET /interventions or /interventions.json
  # def index
    # @interventions = Intervention.all
  # end

  # GET /interventions/1 or /interventions/1.json
  def show
  end

  # GET /interventions/new
  
  def new
    if current_user.is_employee? 
      @intervention = Intervention.new
      @customers = Customer.all
      @buildings = Building.all
      @batteries = Battery.all
      @columns = Column.all
      # @building = Building.where("customer_id = ?", customer.first.id)
    end
  end

  def update_buildings
    @buildings = Building.where("customer_id = ?", params[:customer_id])
    p @buildings
    respond_to do |format|
      format.json { render :json => @buildings}
      p @buildings
    end
  end

  def update_batteries
    @batteries = Battery.where("building_id = ?", params[:building_id])
    p @batteries
    respond_to do |format|
      format.json { render :json => @batteries}
    end
  end

  def update_columns
    @columns = Column.where("battery_id = ?", params[:battery_id])
    respond_to do |format|
      format.json { render :json => @columns}
    end
  end

  # GET /interventions/1/edit
  def edit
  end

  # POST /interventions or /interventions.json
  def create
    @intervention = Intervention.new(intervention_params)

    respond_to do |format|
      if @intervention.save
        format.html { redirect_to intervention_url(@intervention), notice: "Intervention was successfully created." }
        format.json { render :show, status: :created, location: @intervention }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interventions/1 or /interventions/1.json
  def update
    respond_to do |format|
      if @intervention.update(intervention_params)
        format.html { redirect_to intervention_url(@intervention), notice: "Intervention was successfully updated." }
        format.json { render :show, status: :ok, location: @intervention }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interventions/1 or /interventions/1.json
  def destroy
    @intervention.destroy

    respond_to do |format|
      format.html { redirect_to interventions_url, notice: "Intervention was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_intervention
      @intervention = Intervention.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def intervention_params
      params.require(:intervention).permit(:customer_id, :building_id, :battery_id, :column_id, :elevator_id, :employee_id, :start_date_and_time_of_the_intervention, :end_date_and_time_of_the_intervention, :result, :report, :status)
    end
end
