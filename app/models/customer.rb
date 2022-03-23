require 'excon'
require 'json'
require 'dropbox_api'

class Customer < ApplicationRecord
  belongs_to :user
  has_one :address
  has_many :building
  after_save :check_lead

  def address_map
    "#{self.id}"
  end 

  private
  def check_lead
    customer = Customer.last
    leads = Lead.where(e_mail: customer.email_of_the_company_contact)
    unless leads.blank?
      for lead in leads
        unless lead.attached_file_stored_as_a_binary_file == nil
          name = customer.full_name_of_the_company_contact
          folder = name == nil ? 'unnamed' : name
          file = lead.attached_file_stored_as_a_binary_file
          file_name = lead.created_at
          send_to_dropbox folder, file, file_name
          lead.attached_file_stored_as_a_binary_file = nil
          lead.save
        end
      end
    end
  end

  def send_to_dropbox(folder, file, file_name)
    response = Excon.post('https://api.dropboxapi.com/2/files/create_folder_v2',
        :body => "{ \"path\": \"/#{folder}\", \"autorename\": false }",
        :headers => { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{ENV['DROPBOX_KEY']}" }
    )

    result = JSON.parse(response.body)
    if result['metadata']
      send_file folder, file, file_name
    else
      if result['error_summary'] == 'path/conflict/folder/' || result['error_summary'] == 'path/conflict/folder/...' || result['error_summary'] == 'path/conflict/folder/.' || result['error_summary'] == 'path/conflict/folder/..'
        send_file folder, file, file_name
      else
        p "There was an error while creating the folder: #{result['error_summary']}"
      end
    end
  end

  def send_file(folder, file, file_name)
    client = DropboxApi::Client.new(ENV.fetch('DROPBOX_KEY'))
    client.upload_by_chunks "/#{folder}/#{file_name}", file
  end
end
