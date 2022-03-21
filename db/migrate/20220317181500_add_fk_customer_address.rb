class AddFkCustomerAddress < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :customers, :addresses

    add_column :addresses, :customer_id, :bigint
    add_foreign_key :addresses, :customers
  end
end
