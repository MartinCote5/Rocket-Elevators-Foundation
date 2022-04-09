class AddForeignKeyToBuildingInIntervention < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :interventions, :batteries
    add_foreign_key :interventions, :columns, optional: true
    add_foreign_key :interventions, :elevators, optional: true
    add_foreign_key :interventions, :customers
    add_foreign_key :interventions, :employees,optional: true

  end
end
