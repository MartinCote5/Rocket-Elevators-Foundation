class AddCompanyName < ActiveRecord::Migration[7.0]
  def change
    add_column :quotes, :company_name, :string
  end
end
