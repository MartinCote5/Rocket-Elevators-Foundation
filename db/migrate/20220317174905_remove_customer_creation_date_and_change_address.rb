class RemoveCustomerCreationDateAndChangeAddress < ActiveRecord::Migration[7.0]
  def change
    remove_column :customers, :customer_creation_date
    rename_column :customers, :company_headquarters_address, :address_id
    change_column :customers, :address_id, :bigint
  end
end
