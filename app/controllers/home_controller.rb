class HomeController < ApplicationController
  def index
    @lead = Lead.new;
  end

  def residential
  end

  def commercial
  end

  def quote
    @quote = Quote.new;
  end

  def geo
    if current_user
      p '==========================='
      @building =  Building.find(params[:id])
      if current_user.role == 'employee' && !@building.blank?
        # Here we can render the page
      else
        p '==========================='
        p @building
        p '==========================='
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end
end
