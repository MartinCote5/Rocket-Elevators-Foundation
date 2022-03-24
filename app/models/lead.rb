class Lead < ApplicationRecord
    #Create a ticket with attachments.
    require 'rubygems'
    require 'rest_client'
    require 'json'
    after_create :LeadTickets
    def LeadTickets
        freshdesk_domain = 'codeboxx'

        # It could be either your user name or api_key.
        user_name_or_api_key = '5kS4wAETiv9GHoF6I5Qn'

        # If you have given api_key, then it should be x. If you have given user name, it should be password
        password_or_x = 'X'

        #attachments should be of the form array of Hash with files mapped to the key 'resource'.
        json_payload = {    
                        status: 2,
                        unique_external_id: "#{id}",
                        priority: 1,
                        description: "The contact #{full_name_of_the_contact} from company #{company_name} can be reached at email #{e_mail} and at phone number #{phone}. #{department_in_charge_of_the_elevators} has a project named #{project_name} which would require contribution from Rocket Elevators. \n #{project_description}",
                        subject: "#{full_name_of_the_contact} from #{company_name}",
                        attachments: File.new("#{attached_file_stored_as_a_binary_file}")}.to_json
        freshdesk_api_path = 'api/v2/tickets'

        freshdesk_api_url  = "https://#{freshdesk_domain}.freshdesk.com/#{freshdesk_api_path}"

        site = RestClient::Resource.new(freshdesk_api_url, user_name_or_api_key, password_or_x)

        begin
                response = site.post(json_payload, :content_type=>'application/json')
        puts "response_code: #{response.code} \nLocation Header: #{response.headers[:Location]} \nresponse_body: #{response.body} \n"
        rescue RestClient::Exception => exception
        puts 'API Error: Your request is not successful. If you are not able to debug this error properly, mail us at support@freshdesk.com with the follwing X-Request-Id'
        puts "X-Request-Id : #{exception.response.headers[:x_request_id]}"
        puts "Response Code: #{exception.response.code} \nResponse Body: #{exception.response.body} \n"
        end
    end
end
