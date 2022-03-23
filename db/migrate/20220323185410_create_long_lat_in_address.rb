class CreateLongLatInAddress < ActiveRecord::Migration[7.0]
  def change
    create_table :long_lat_in_addresses do |t|
      add_column :addresses, :longitude, :float
      add_column :addresses, :latitude, :float

      t.timestamps
    end
  end
end
