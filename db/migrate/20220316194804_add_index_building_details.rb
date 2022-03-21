class AddIndexBuildingDetails < ActiveRecord::Migration[7.0]
  def change
    add_index :building_details, :buildingId
  end
end
