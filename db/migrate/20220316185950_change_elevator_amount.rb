class ChangeElevatorAmount < ActiveRecord::Migration[7.0]
  def change
    rename_column :quotes, :amount_of_elevators, :elevator_amount
  end
end
