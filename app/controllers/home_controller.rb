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
      @building =  Building.where(id: params[:id])[0]
      if current_user.role == 'employee' && !@building.blank?
        # Here we can render the page
        @number_of_elevators = 0
        for column in @building.battery.column
          @number_of_elevators += column.elevator.count
        end
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end
end
