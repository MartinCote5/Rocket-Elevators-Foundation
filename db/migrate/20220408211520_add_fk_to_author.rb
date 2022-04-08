class AddFkToAuthor < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :interventions, :buildings
  end
end
