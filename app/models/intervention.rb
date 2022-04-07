class Intervention < ApplicationRecord
    #Create a ticket with attachments.
    require 'rubygems'
    require 'rest_client'
    require 'json'
    after_create :InterventionTickets

    def InterventionTickets
     
        # Your freshdesk domain
        freshdesk_domain = 'rocketelevators-supportdesk'
    
        # It could be either your user name or api_key.
        user_name_or_api_key = ENV["FRESHDESK_API_KEY"]

        # If you have given api_key, then it should be x. If you have given user name, it should be password
        password_or_x = 'X'





        p elevator_id
        elevator_id = self.elevator_id == nil ? "n/a" : self.elevator_id
        p "-----------------"
        p elevator_id
        p "-----------------"
        p elevator_id

        # unless self.elevator_id == 40
        #     p "-----------------"
        #     p "-----------------"
        #     elevator_id = "n/a"
        #     p "-----------------"
        # end

        # if column_id == nil 
        #     column_id = "n/a"
        # end
        # p elevator_id
        # puts "--------------------------------------------------"
        # puts "--------------------------------------------------"
        #puts elevator_id
        # puts "--------------------------------------------------"
        # puts "--------------------------------------------------"
        # if elevator_id == nil
        #     puts "--------------------------------------------------"
        #     puts "--------------------------------------------------"
        #     puts elevator_id    
        #     puts "--------------------------------------------------"
        #     puts "--------------------------------------------------"
        #     b = "n/a"
        #     # elevator_id.to_s
            # elevator_id = 40
        #     puts "--------------------rrrrrrrrrrrrrrrrrrrr------------------------------"
        # end
        #puts b
        # puts "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhfffffffhhhhhhhhhhhhhhhhhhhhhhhhh"
        # puts "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"
        puts "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"
        puts "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"
        puts "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"
        puts elevator_id
        puts elevator_id
        puts elevator_id
        puts elevator_id
        puts elevator_id
        puts "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"
        puts "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"
        # puts "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"
        # puts "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"
        # puts "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"
        if employee_id != nil
            puts "...."
            puts elevator_id
        json_payload = {
                        unique_external_id: "#{id}",
                        status: 2,            
                        priority: 1,
                        type: "Incident",
                        description: " An intervention is requested for the customer compagny #{Customer.find(customer_id).company_name} in the following field : <br>
                        -Battery number : #{battery_id} <br>
                        -Building number : #{building_id} <br>
                        -Column number : #{column_id} <br>
                        -Elevator number : #{elevator_id} <br>
                        The employee #{Employee.find(employee_id).first_name} #{Employee.find(employee_id).last_name} is assigned to the task. <br>
                        Report : <br>
                        #{report}<br> <br> <br> 
                        the requester** " , 
                        subject: "Intervention ticket for #{Customer.find(customer_id).company_name}"}.to_json
        else
            json_payload = {
                            unique_external_id: "#{id}",
                            title: "blalba", 
                            status: 2,            
                            priority: 1,
                            type: "Incident",
                            description: " An intervention is requested for the customer compagny #{Customer.find(customer_id).company_name} in the following field : <br>
                            -Battery number : #{battery_id} <br>
                            -Building number : #{building_id} <br>
                            -Column number : #{column_id} <br>
                            -Elevator number : #{elevator_id} <br>
                            There is no employee assigned to this intervention! <br>
                            Report : <br>
                            #{report}<br> <br> <br> 
                            the requester** " , 
                            subject: "#{employee_id} from #{employee_id}"}.to_json
        end
                        
        freshdesk_api_path = 'api/v2/tickets'

        freshdesk_api_url  = "https://#{freshdesk_domain}.freshdesk.com/#{freshdesk_api_path}"

        site = RestClient::Resource.new(freshdesk_api_url, user_name_or_api_key, password_or_x)

        begin
        response = site.post(json_payload, :content_type=>'application/json')
        puts "response_code: #{response.code} \n Location Header: #{response.headers[:location]}\n response_body: #{response.body}"
        rescue RestClient::Exception => exception
        puts 'API Error: Your request is not successful. If you are not able to debug this error properly, mail us at support@freshdesk.com with the follwing X-Request-Id'
        puts "X-Request-Id : #{exception.response.headers[:x_request_id]}"
        puts "Response Code: #{exception.response.code} Response Body: #{exception.response.body} "
        end
    end
end
