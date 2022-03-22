class Elevator < ApplicationRecord
  belongs_to :column

  def blabla

    p "-----------------------------------------------"
    p "bbbblblblbbl"
    p "-----------------------------------------------"
  end


  after_update :elevator_status
  def elevator_status
    p id
    p self.column.battery.building.full_name_of_the_building_administrator
    p self.column.battery.building.phone_number_of_the_building_administrator
    # p after_save :status
    if status == "intervention"    
        
        
        @client = Twilio::REST::Client.new ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"]
       

        @client.messages.create(
        from: ENV["TWILIO_PHONE_NUMBER"],
        to: self.column.battery.building.phone_number_of_the_building_administrator,
        body: "Hello #{self.column.battery.building.full_name_of_the_building_administrator}, 
        the elevator #{id} in the column #{self.column.id} need to be repaired!"
        )
        puts "almost there"
      
    end  
  end
end


