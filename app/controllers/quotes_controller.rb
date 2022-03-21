class QuotesController < ApplicationController
 
  protect_from_forgery with: :null_session
  before_action :set_quote, only: %i[ show edit update destroy ]

  # GET /quotes or /quotes.json
  def index
    @quotes = Quote.all
  end

  # GET /quotes/1 or /quotes/1.json
  def show
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
  end

  # POST /quotes or /quotes.json
  def create
    @quote = Quote.new(quote_params)
    respond_to do |format|
      if @quote.save
        format.html { redirect_to(root_path, :notice => "Your quote was successfully sent!")}
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quote_params
      
      params.require(:quote).permit(:buildingType, :number_of_floors, :number_of_basements, :number_of_apartments, :number_of_parking_spots, :elevator_amount, :number_of_companies, :maximum_occupancy, :number_of_corporations, :business_hours, :range, :company_name, :email)
    end
end
