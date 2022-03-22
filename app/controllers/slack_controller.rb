require 'slack-notifier'
require 'active_record'
after_update :elevatorNotification
def elevatorNotification
    p "test1"
    @elevator = Elevator.all
    if @elevator.status_changed? == true
        p "test2"
        notifier = Slack::Notifier.new "https://hooks.slack.com/services/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"
        notifier.ping "The Elevator #{id} with Serial Number #{serial_number} changed status from #{status_change[0]} to #{status_change[1]}"
    end
end