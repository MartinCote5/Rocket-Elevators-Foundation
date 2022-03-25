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
                        subject: "#{full_name_of_the_contact} from #{company_name}"}.to_json
        if attached_file_stored_as_a_binary_file == true
            json_payload = {   attachments: "#{attached_file_stored_as_a_binary_file}"}.to_json
        end
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
    require 'sendgrid-ruby'
    include SendGrid
    after_create :SENDGRID_API_KEY
   
    def SENDGRID_API_KEY
        lead = Lead.last
        fullName = lead.full_name_of_the_contact
        projectName = lead.project_name
        email = lead.e_mail

        mail = Mail.new
        mail.from = Email.new(email: 'codeboxx.h22@gmail.com')
        personalization = Personalization.new
        personalization.add_to(Email.new(email: email))
        personalization.add_dynamic_template_data({
            "subject" => "Thanks for contacting us",
            "fullName" => fullName,
            "projectName" => projectName,
            "email" => email
        })
        mail.add_personalization(personalization)
        mail.template_id = 'd-9e50f25cb38f4219889970b77111903c'

        sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
        begin
            response = sg.client.mail._("send").post(request_body: mail.to_json)
        rescue Exception => e
            puts e.message
        end
    end
end
