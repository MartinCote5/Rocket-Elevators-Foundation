class Quote < ApplicationRecord
    #Create a ticket with attachments.
    require 'rubygems'
    require 'rest_client'
    require 'json'
    after_create :QuoteTickets

    def QuoteTickets

        # Your freshdesk domain
        freshdesk_domain = 'codeboxx'

        # It could be either your user name or api_key.
        user_name_or_api_key = ENV["FRESHDESK_API_KEY"]

        # If you have given api_key, then it should be x. If you have given user name, it should be password
        password_or_x = 'X'

        json_payload = {
                        unique_external_id: "#{id}",
                        status: 2,            
                        priority: 1,
                        description: "The contact #{full_name_of_the_contact} from company #{company_name} can be reached at email #{email}. A quote as been created and is containing #{elevator_amount} elevators. The building has #{number_of_floors} floors and #{number_of_basements} basements. This would require contribution from Rocket Elevators.",
                        subject: "#{full_name_of_the_contact} from #{company_name}"}.to_json

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
