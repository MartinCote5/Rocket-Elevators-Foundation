class AddFkCustomerUser < ActiveRecord::Migration[7.0]
  def change
    change_column :customers, :userId, :bigint
    rename_column :customers, :userId, :user_id
    add_foreign_key :customers, :users
  end
end
