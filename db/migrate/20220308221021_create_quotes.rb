class CreateQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :quotes do |t|
      t.string :type
      t.integer :number_of_floors
      t.integer :number_of_basements
      t.integer :number_of_apartments
      t.integer :number_of_parking_spots
      t.integer :number_of_elevators
      t.integer :number_of_companies
      t.integer :maximum_occupancy
      t.integer :number_of_corporations
      t.integer :business_hours
      t.string :standard
      t.string :premium
      t.string :excelium
     
      t.timestamps
    end
  end
end

