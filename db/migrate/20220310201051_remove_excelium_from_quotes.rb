class RemoveExceliumFromQuotes < ActiveRecord::Migration[7.0]
  def change
    remove_column :quotes, :excelium, :string
  end
end
