json.extract! lead, :id, :full_name_of_the_contact, :company_name, :e_mail, :phone, :project_name, :project_description, :department_in_charge_of_the_elevators, :message, :attached_file_stored_as_a_binary_file,  :created_at, :updated_at
json.url lead_url(lead, format: :json)
