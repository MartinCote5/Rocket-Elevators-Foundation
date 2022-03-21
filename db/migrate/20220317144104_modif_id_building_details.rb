class ModifIdBuildingDetails < ActiveRecord::Migration[7.0]
  def change
      rename_column :building_details, :buildingId, :building_id
      change_column :building_details, :building_id, :bigint
      add_foreign_key :building_details, :buildings
   end
end
