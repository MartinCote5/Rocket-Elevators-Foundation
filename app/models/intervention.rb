class Intervention < ApplicationRecord
    belongs_to :customer
    belongs_to :building
    belongs_to :battery
    belongs_to :column, optional: true
    belongs_to :elevator, optional: true
    belongs_to :employee, optional: true
    belongs_to :author, class_name: 'Employee'
    
    #Create a ticket with attachments.
    require 'rubygems'
    require 'rest_client'
    require 'json'
    after_create :interventionTickets

    def interventionTickets
        ## == PaperTrail ==
        # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0
        # Your freshdesk domain
        freshdesk_domain = 'rocketelevators-supportdesk'
    
        # It could be either your user name or api_key.
        user_name_or_api_key = ENV["FRESHDESK_API_KEY"]

        # If you have given api_key, then it should be x. If you have given user name, it should be password
        password_or_x = 'X'
        
        column_id = self.column_id == nil ? "n/a" : self.column_id
        elevator_id = self.elevator_id == nil ? "n/a" : self.elevator_id

        if employee_id != nil 
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
                        #{author.first_name} #{author.last_name}", 
                        subject: "Intervention ticket from #{author.first_name} #{author.last_name}"}.to_json
        end

        if employee_id == nil 
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
                            There is no employee assigned to this intervention! <br>
                            Report : <br>
                            #{report}<br> <br> <br> 
                            #{author.first_name} #{author.last_name}" , 
                            subject: "Intervention ticket from #{author.first_name} #{author.last_name}"}.to_json
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
