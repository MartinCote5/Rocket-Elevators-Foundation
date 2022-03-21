class LeadsController < ApplicationController
  before_action :set_lead, only: %i[ show edit update destroy ]

 
 
  # redirect_to login_path, info: "invaled emid"
  # POST /leads or /leads.json
  def create
    @lead = Lead.new(lead_params)

    if @lead.attached_file_stored_as_a_binary_file != nil
      @lead.attached_file_stored_as_a_binary_file = @lead.attached_file_stored_as_a_binary_file.read
    end
 
    respond_to do |format|
      if @lead.save
        format.html { redirect_to(root_path, :notice => "Your message was successfully sent!")}
        format.json { render :show, status: :created, location: @lead }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lead
      @lead = Lead.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lead_params
      params.require(:lead).permit(:full_name_of_the_contact, :company_name, :e_mail, :phone, :project_name, :project_description, :department_in_charge_of_the_elevators, :message, :attached_file_stored_as_a_binary_file)
    end
end
