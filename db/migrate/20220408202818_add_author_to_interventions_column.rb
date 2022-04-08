class AddAuthorToInterventionsColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :interventions, :author, :bigint
  end
end
