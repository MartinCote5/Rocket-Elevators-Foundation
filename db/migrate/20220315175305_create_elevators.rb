class CreateElevators < ActiveRecord::Migration[7.0]
  def change
    create_table :elevators do |t|
      t.bigint :columnId
      t.integer :serial_number
      t.string :model
      t.string :type
      t.string :status
      t.date :date_of_commissioning
      t.date :date_of_last_inspection
      t.text :certificate_of_inspection
      t.text :information
      t.text :notes

      t.timestamps
    end
  end
end
