class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.bigint :user_id
      t.string :first_name
      t.string :last_name
      t.string :title
      t.timestamps
    end
  end
end
