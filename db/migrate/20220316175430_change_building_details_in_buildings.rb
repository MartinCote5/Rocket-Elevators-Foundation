class ChangeBuildingDetailsInBuildings < ActiveRecord::Migration[7.0]
  def change
    add_column :buildings, :building_details, :bigint
  end
end


