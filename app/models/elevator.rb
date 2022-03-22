class Elevator < ApplicationRecord
  belongs_to :column

  def blabla

    p "-----------------------------------------------"
    p "bbbblblblbbl"
    p "-----------------------------------------------"
  end


  after_update :elevator_status
  def elevator_status
    if status == "intervention"    
        @client = Twilio::REST::Client.new ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"]

        @client.messages.create(
        from: ENV["TWILIO_PHONE_NUMBER"],
        to: '8196769493',
        body: 'Hey vvvv!'
        )
        puts "almost there"
      
    end  
  end




  


end



# def dimcustomers(conn)
#   customers = Customer.all
#   for customer in customers
#     count = 0
#     buildings = customer.building
#     city = customer.address.city
#     for building in buildings
#       battery = building.battery
#       columns = battery.column
#       for column in columns
#         count += column.elevator.count
#       end
#     end
#     conn.exec("INSERT INTO dimcustomers(creation_date, company_name, full_name_of_the_company_main_contact, email_of_the_company_main_contact, elevator_amount, customer_city)VALUES ('#{customer.created_at}', '#{customer.company_name.gsub(/\'/, '\'\'')}', '#{customer.full_name_of_the_company_contact.gsub(/\'/, '\'\'')}', '#{customer.email_of_the_company_contact}', #{count}, '#{city.gsub(/\'/, '\'\'')}')")
#   end
# end