class Elevator < ApplicationRecord
    require 'slack-notifier'
    belongs_to :column
    before_update :elevatorNotification
    after_update :elevator_status
    def elevatorNotification
        if status_changed? == true
            notifier = Slack::Notifier.new "https://hooks.slack.com/services/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"
            notifier.ping "The Elevator #{id} with Serial Number #{serial_number} changed status from #{status_change[0]} to #{status_change[1]}"
        end
    end
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


