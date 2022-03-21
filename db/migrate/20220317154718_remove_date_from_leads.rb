class RemoveDateFromLeads < ActiveRecord::Migration[7.0]
  def change
    remove_column :leads, :date_of_the_contact_request, :date
  end
end
