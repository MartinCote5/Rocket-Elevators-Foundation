class CreateBatteries < ActiveRecord::Migration[7.0]
  def change
    create_table :batteries do |t|
      t.string :buildingId
      t.string :type
      t.string :status
      t.string :employeeId
      t.date :date_of_commissioning
      t.date :date_of_last_inspection
      t.string :certificate_of_operations
      t.string :information
      t.text :notes

      t.timestamps
    end
  end
end
