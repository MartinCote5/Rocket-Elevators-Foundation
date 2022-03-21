class ChangeSuiteOrApartmentToString < ActiveRecord::Migration[7.0]
  def change
    change_column :addresses, :suite_or_apartment, :string
  end
end
