class Quote < ApplicationRecord
    #Create a ticket with cc_emails attributes.
    require 'rubygems'
    require 'rest_client'
    require 'json'

    # Your freshdesk domain
    freshdesk_domain = 'https://codeboxxh22.myfreshworks.com'

    # It could be either your user name or api_key.
    user_name_or_api_key = '5kS4wAETiv9GHoF6I5Qn'

    # If you have given api_key, then it should be x. If you have given user name, it should be password
    password_or_x = 'X'

    json_payload = { 
                    buildingType: "",
                    number_of_floors: "",
                    number_of_basements: "",
                    number_of_apartments: "",
                    number_of_parking_spots: "",
                    elevator_amount: "",
                    number_of_companies: "",
                    maximum_occupancy: "",
                    number_of_corporations: "",
                    business_hours: "",
                    created_at: "",
                    updated_at: "",
                    range: "",
                    company_name: "",
                    email: "", }.to_json
    freshdesk_api_path = 'api/v2/tickets'

    freshdesk_api_url  = "https://codeboxxh22.myfreshworks.com/#{freshdesk_api_path}"

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
