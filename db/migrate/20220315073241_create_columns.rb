class CreateColumns < ActiveRecord::Migration[7.0]
  def change
    create_table :columns do |t|
      t.string :batteryId
      t.string :type
      t.string :number_of_floors_served
      t.string :status
      t.string :information
      t.text :notes

      t.timestamps
    end
  end
end
