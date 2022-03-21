class ChangeColumnBuildingDetailsName < ActiveRecord::Migration[7.0]
  def change
    rename_column :buildings, :building_details, :buildingId
  end
end
