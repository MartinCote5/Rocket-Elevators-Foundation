class Elevator < ApplicationRecord
  belongs_to :column

  after_update :elevator_status
  def elevator_status
    if status == "intervention"    
        @client = Twilio::REST::Client.new ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"]
    
        @client.messages.create(
        from: ENV["TWILIO_PHONE_NUMBER"],
        to: self.column.battery.building.technical_contact_phone_for_the_building,
        body: "Elevator #{id} is now in intervention."
        )
    end  
  end
end


