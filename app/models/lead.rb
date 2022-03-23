class Lead < ApplicationRecord
    require 'sendgrid-ruby'
    include SendGrid
    after_save :SENDGRID_API_KEY
   
    def SENDGRID_API_KEY
      from = Email.new(email: 'codeboxx.h22@gmail.com')
      to = Email.new(email: 'jsgotty74@gmail.com')
      subject = 'This is a test message!'
      content = Content.new(type: 'text/plain', value: 'Greetings [lead.name], We thank you for contacting Rocket Elevators to discuss the opportunity to contribute to your project [lead.project]. A representative from our team will be in touch with you very soon. We look forward to demonstrating the value of our solutions and helping you choose the appropriate product given your requirements.
        
        We’ll Talk soon
            
        The Rocket Team.')
      mail = Mail.new(from, subject, to, content)
      mail.template_id = 'd-9e50f25cb38f4219889970b77111903c'
      sg = SendGrid::API.new(api_key: ENV["SENDGRID_API_KEY"])
      response = sg.client.mail._('send').post(request_body: mail.to_json)
      puts response.status_code
      puts response.body
      puts response.headers
    end
end
