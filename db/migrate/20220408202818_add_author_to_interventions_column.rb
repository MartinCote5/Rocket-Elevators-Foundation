class AddAuthorToInterventionsColumn < ActiveRecord::Migration[7.0]
  def change
    add_reference :interventions, :author, foreign_key: {to_table: :employees}
  end
end
