class AddBuildingColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :buildings, :information_key, :string
    add_column :buildings, :value, :string
  end
end
