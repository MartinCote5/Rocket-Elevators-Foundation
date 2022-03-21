class ChangeAllIdOfForeignkeyOnBigint < ActiveRecord::Migration[7.0]
  def change  
      rename_column :buildings, :customerId, :customer_id
      add_foreign_key :buildings, :customers
      
      rename_column :buildings, :address_of_the_building, :address_id
      add_foreign_key :buildings, :addresses
  
      rename_column :batteries, :buildingId, :building_id
      change_column :batteries, :building_id, :bigint
      add_foreign_key :batteries, :buildings
      
      
      rename_column :columns, :batteryId, :battery_id
      change_column :columns, :battery_id, :bigint
      add_foreign_key :columns, :batteries
  
      
      rename_column :elevators, :columnId, :column_id
      change_column :elevators, :column_id, :bigint
      add_foreign_key :elevators, :columns
  
      #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
      #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
