class AddFkEmpUsr < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :employees, :users
  end
end
