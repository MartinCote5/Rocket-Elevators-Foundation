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
      @buildings =  Building.all
      @columns = Column.all
      # Customer?
      if current_user.role == 'employee' && !@buildings.blank?
        # Here we can render the page
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end
end
