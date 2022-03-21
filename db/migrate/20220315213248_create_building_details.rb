class CreateBuildingDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :building_details do |t|
      t.bigint :buildingId
      t.string :information_Key
      t.string :value

      t.timestamps
    end
  end
end
