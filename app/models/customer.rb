class Customer < ApplicationRecord
  belongs_to :user
  has_one :address
  has_many :building
  after_save :check_lead

  private
  def check_lead
    customer = Customer.last
    leads = Lead.where(e_mail: customer.email_of_the_company_contact)
    unless leads.blank?
      for lead in leads
        unless lead.attached_file_stored_as_a_binary_file == nil
          send_to_dropbox
        end
      end
    end
  end

  def send_to_dropbox
    p '-----------------------------------------'
    p 'In send to dropbox'
    p '-----------------------------------------'
  end
end
