class TypeTobuildingType < ActiveRecord::Migration[7.0]
  def change
    rename_column :quotes, :type, :buildingType
  end
end
