class ChangeAmountOfElevator < ActiveRecord::Migration[7.0]
  def change
    rename_column :quotes, :number_of_elevators, :amount_of_elevators
  end
end
