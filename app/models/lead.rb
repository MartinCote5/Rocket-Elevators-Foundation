class Lead < ApplicationRecord
    require 'sendgrid-ruby'
    include SendGrid
    after_save :SENDGRID_API_KEY
   
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
