class CreateInterventions < ActiveRecord::Migration[7.0]
  def change
    create_table :interventions do |t|
      t.bigint :customer_id
      t.bigint :building_id
      t.bigint :battery_id
      t.bigint :column_id
      t.bigint :elevator_id
      t.bigint :employee_id
      t.timestamp :start_date_and_time_of_the_intervention
      t.timestamp :end_date_and_time_of_the_intervention
      t.string :result
      t.text :report
      t.string :status

      t.timestamps
    end
  end
end
