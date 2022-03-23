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
      @customer =  Customer.where(id: params[:id])[0]
      if current_user.role == 'employee' && !@customer.blank?
        # Here we can render the page
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end
end
