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
<<<<<<< HEAD
      if current_user.role == 'employee' && !@buildings.blank?
        # Here we can render the page
        @number_of_elevators = 0
        @buildings.each do |building|
          puts building
        end
=======
      # Customer?
      if current_user.role == 'employee' && !@buildings.blank?
        # Here we can render the page
>>>>>>> development
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end
end
