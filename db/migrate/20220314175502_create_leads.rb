class CreateLeads < ActiveRecord::Migration[7.0]
  def change
    create_table :leads do |t|
      t.string :full_name_of_the_contact
      t.string :company_name
      t.string :e_mail
      t.string :phone
      t.string :project_name
      t.text :project_description
      t.string :department_in_charge_of_the_elevators
      t.text :message
      t.text :attached_file_stored_as_a_binary_file
      t.date :date_of_the_contact_request

      t.timestamps
    end
  end
end
